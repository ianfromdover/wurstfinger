//
//  GridKeyboardFactory.swift
//  Wurstfinger
//
//  Factory for creating grid-based keyboard definitions.
//

import Foundation

/// Factory for creating complete grid-based keyboard definitions.
/// All shared structure (punctuation, utility keys, arrangements, shifted layer)
/// is generated automatically — only language-specific parameters are needed.
enum GridKeyboardFactory {
    /// Creates a complete keyboard definition from language-specific parameters.
    ///
    /// - Parameters:
    ///   - id: Unique keyboard identifier (e.g. "en_US")
    ///   - title: Display name (e.g. "English")
    ///   - localeIdentifier: Locale string for uppercasing (e.g. "en_US")
    ///   - centerCharacters: 3×4 grid of center tap characters
    ///   - directionalOverrides: Per-slot overrides that replace CommonKeys defaults.
    ///     Only `.swipeUp` and `.swipeDown` are meaningful (`.twoWayVertical` restriction).
    ///   - returnOverrides: Per-slot return-swipe outputs that replace the
    ///     auto-generated uppercase return action.
    ///   - circularOverrides: Per-slot output of the circle gesture.
    ///   - composeRuleOverrides: Language-specific compose rules.
    ///   - supportsCapitalization: Whether the script distinguishes letter case.
    ///   - numericBackToAlphaLabel: Label for numeric back-to-alpha key.
    ///   - numericDigits: Digit set (indexed by value 0–9).
    ///   - inputMethod: Input method (.direct, .telex, .hangul).
    static func layout(
        id: String,
        title: String,
        localeIdentifier: String,
        centerCharacters: [[String]],
        directionalOverrides: [String: [GestureType: String]] = [:],
        returnOverrides: [String: [GestureType: String]] = [:],
        circularOverrides: [String: String] = [:],
        composeRuleOverrides: ComposeRuleSet? = nil,
        supportsCapitalization: Bool = true,
        numericBackToAlphaLabel: String = NumericLayouts.defaultBackToAlphaLabel,
        numericDigits: [String] = NumericLayouts.westernDigits,
        inputMethod: InputMethodType = .direct,
        combineRuleSet: ComposeRuleSet? = nil
    ) -> KeyboardDefinition {
        precondition(
            centerCharacters.count == 3 && centerCharacters.allSatisfy { $0.count == 4 },
            "centerCharacters must be a 3×4 matrix"
        )

        let locale = Locale(identifier: localeIdentifier)
        let arrangements = StandardArrangements.grid3x3

        // 1. Build 12 letter keys from center characters + shared defaults + overrides
        var letterKeys: [String: KeyConfig] = [:]
        for (rowIdx, row) in centerCharacters.enumerated() {
            for (colIdx, char) in row.enumerated() {
                let slotId = GridSlot.letterSlots[rowIdx][colIdx]

                // Start with shared defaults for this slot
                var bindings = CommonKeys.defaultSlotBindings[slotId] ?? [:]

                // Apply language-specific overrides (replace default binding for that gesture).
                if let overrides = directionalOverrides[slotId] {
                    for (gesture, text) in overrides {
                        let isLetter = text.unicodeScalars.contains { CharacterSet.letters.contains($0) }
                        let uppercased = text.keyboardUppercased(with: locale)
                        let returnAction: KeyAction? = isLetter && uppercased != text
                            ? .commitText(uppercased)
                            : nil
                        bindings[gesture] = KeyBinding(
                            label: text, action: .commitText(text),
                            category: nil, returnAction: returnAction,
                            accessibilityLabel: inheritedAccessibilityName(
                                replacing: bindings[gesture], isLetter: isLetter
                            )
                        )
                    }
                }

                // Set the tap binding from center character
                bindings[.tap] = KeyBinding(
                    label: char, action: .commitText(char),
                    category: nil, returnAction: nil, accessibilityLabel: nil
                )

                // Apply explicit return-swipe outputs
                if let returns = returnOverrides[slotId] {
                    for (gesture, text) in returns {
                        guard gesture.isSwipe else {
                            preconditionFailure(
                                "returnOverrides[\(slotId)][\(gesture)] must target a swipe gesture"
                            )
                        }
                        guard let base = bindings[gesture] else {
                            preconditionFailure(
                                "returnOverrides[\(slotId)][\(gesture)] has no base binding"
                            )
                        }
                        bindings[gesture] = KeyBinding(
                            label: base.label, action: base.action,
                            category: base.category, returnAction: .commitText(text),
                            accessibilityLabel: base.accessibilityLabel
                        )
                    }
                }

                // Circle gesture
                if let text = circularOverrides[slotId] {
                    let circle = KeyBinding(
                        label: text, action: .commitText(text),
                        category: nil, returnAction: nil, accessibilityLabel: nil
                    )
                    bindings[.circularClockwise] = circle
                    bindings[.circularCounterclockwise] = circle
                }

                letterKeys[slotId] = KeyConfig(
                    id: slotId, bindings: bindings, swipeMode: .twoWayVertical,
                    slideType: .none, style: .primary, tapCycleActions: nil
                )
            }
        }

        // 2. Merge utility keys
        precondition(
            Set(letterKeys.keys).isDisjoint(with: CommonKeys.allUtilityKeys.keys),
            "letter and utility key IDs must not overlap"
        )
        var allKeys = letterKeys.merging(CommonKeys.allUtilityKeys) { letter, _ in letter }
        // Bind the space-bar hold-for-zero to this layout's own digit set
        allKeys[UtilitySlot.space] = CommonKeys.spacebar(zeroDigit: numericDigits.first ?? "0")

        // 3. Build base mode
        let baseMode = KeyboardMode(
            name: ModeNames.main,
            keys: allKeys,
            arrangements: arrangements,
            autoTransitions: [:]
        )

        var modes: [String: KeyboardMode] = [
            ModeNames.numeric: NumericLayouts.phone(
                digits: numericDigits, backToAlphaLabel: numericBackToAlphaLabel
            ),
        ]

        if supportsCapitalization {
            // Generate the shifted base once and derive both shifted + caps lock.
            let shiftedBase = baseMode.generateShifted(locale: locale)

            // 4. Shifted — shift-up on r2c0 points to capsLock.
            modes[ModeNames.shifted] = shiftedBase
                .with(autoTransitions: [.letter: ModeNames.main])
                .replacingShiftUpBinding(
                    label: "⇧", action: .switchMode(ModeNames.capsLock),
                    accessibilityLabel: String(localized: "Shift")
                )

            // 5. Caps lock — shift-up on r2c0 cycles back to main.
            modes[ModeNames.capsLock] = shiftedBase
                .with(name: ModeNames.capsLock)
                .replacingShiftUpBinding(
                    label: "⇪", action: .switchMode(ModeNames.main),
                    accessibilityLabel: nil
                )

            // 6. Main mode — no binding removal needed (r2c0.swipeDown is a letter,
            //    not a back-to-main hint; that was unique to the old midRight layout).
            modes[ModeNames.main] = baseMode
        } else {
            // Caseless script: remove the auto-generated shift affordance from r2c0
            // while keeping any language-specific letter that a directional override
            // placed on the swipe-up gesture.
            modes[ModeNames.main] = baseMode
                .removingBinding(
                    keyId: GridSlot.r2c0, gesture: .swipeUp,
                    ifAction: .switchMode(ModeNames.shifted)
                )
        }

        // 7. Assemble definition
        return KeyboardDefinition(
            title: title,
            id: id,
            localeIdentifier: localeIdentifier,
            modes: modes,
            defaultMode: ModeNames.main,
            settings: KeyboardDefinitionSettings(
                autoCapitalize: supportsCapitalization,
                composeRuleOverrides: composeRuleOverrides,
                inputMethod: inputMethod,
                combineRuleSet: combineRuleSet
            ),
            numericBackToAlphaLabel: numericBackToAlphaLabel,
            numericDigits: numericDigits
        )
    }

    /// VoiceOver name a directional override inherits from the shared binding it
    /// displaces, or nil when it must not inherit one.
    private static func inheritedAccessibilityName(
        replacing displaced: KeyBinding?,
        isLetter: Bool
    ) -> String? {
        guard !isLetter, let displaced, case .commitText = displaced.action else { return nil }
        return displaced.accessibilityLabel
    }
}