//
//  CommonKeys.swift
//  Wurstfinger
//
//  Shared key definitions reusable across all keyboard layouts.
//

import Foundation

/// Shared key definitions reusable across all keyboard layouts.
/// Utility keys and default punctuation/symbol bindings for the 4-column grid.
enum CommonKeys {
    // MARK: - Utility Keys

    /// Clipboard key: Copy (swipeUp) / Cut (tap) / Paste (swipeDown).
    static let clipboard: KeyConfig = {
        var bindings: [GestureType: KeyBinding] = [:]
        bindings[.tap] = KeyBinding(
            label: "", action: .cut, category: .utility,
            returnAction: nil, accessibilityLabel: String(localized: "Cut")
        )
        bindings[.swipeUp] = KeyBinding(
            label: "", action: .copy, category: .utility,
            returnAction: nil, accessibilityLabel: String(localized: "Copy")
        )
        bindings[.swipeDown] = KeyBinding(
            label: "", action: .paste, category: .utility,
            returnAction: nil, accessibilityLabel: String(localized: "Paste")
        )
        return KeyConfig(
            id: UtilitySlot.clipboard, bindings: bindings,
            swipeMode: .twoWayVertical, slideType: .none,
            style: .utility, tapCycleActions: nil
        )
    }()

    /// Autocomplete key: tap inserts "auto" (MVP placeholder).
    static let autocomplete: KeyConfig = KeyConfig.utility(
        UtilitySlot.autocomplete, label: "auto", action: .autocomplete,
        accessibilityLabel: String(localized: "Autocomplete")
    )

    /// Globe key: switches input method. Now accessed via r3c0.swipeDown.
    static let globe: KeyConfig = {
        var bindings: [GestureType: KeyBinding] = [:]
        bindings[.tap] = KeyBinding(
            label: "", action: .none,
            category: .utility, returnAction: nil,
            accessibilityLabel: String(localized: "Switch keyboard")
        )
        bindings[.swipeLeft] = KeyBinding(
            label: "", action: .advanceToNextInputMode,
            category: .utility, returnAction: nil,
            accessibilityLabel: String(localized: "Switch keyboard")
        )
        bindings[.swipeDown] = KeyBinding(
            label: "", action: .dismissKeyboard,
            category: .utility, returnAction: nil,
            accessibilityLabel: String(localized: "Hide keyboard")
        )
        bindings[.swipeRight] = KeyBinding(
            label: "", action: .switchToNextLanguage,
            category: .utility, returnAction: nil,
            accessibilityLabel: String(localized: "Next language")
        )
        return KeyConfig(
            id: UtilitySlot.globe, bindings: bindings,
            swipeMode: .fourWayCross, slideType: .none,
            style: .utility, tapCycleActions: nil,
            accessibilityActivationGesture: .swipeLeft
        )
    }()

    static let delete = KeyConfig.utility(
        UtilitySlot.delete, label: "⌫", action: .deleteBackward,
        swipeMode: .twoWayHorizontal, slideType: .delete,
        accessibilityLabel: String(localized: "Delete")
    )

    /// Return key: tap = newline, swipeDown = dismiss keyboard.
    static let `return`: KeyConfig = {
        var bindings: [GestureType: KeyBinding] = [:]
        bindings[.tap] = KeyBinding(
            label: "↵", action: .newline, category: .utility,
            returnAction: nil, accessibilityLabel: String(localized: "New line")
        )
        bindings[.swipeDown] = KeyBinding(
            label: "", action: .dismissKeyboard, category: .utility,
            returnAction: nil, accessibilityLabel: String(localized: "Hide keyboard")
        )
        return KeyConfig(
            id: UtilitySlot.return, bindings: bindings,
            swipeMode: .twoWayVertical, slideType: .none,
            style: .utility, tapCycleActions: nil
        )
    }()

    /// r3c0 (bottom-left key): tap = 123 (numeric), swipeUp = emoji (inert for now),
    /// swipeDown = next input mode.
    static let r3c0: KeyConfig = {
        var bindings: [GestureType: KeyBinding] = [:]
        bindings[.tap] = KeyBinding(
            label: "123", action: .switchMode(ModeNames.numeric),
            category: .utility, returnAction: nil,
            accessibilityLabel: String(localized: "Numbers")
        )
        bindings[.swipeUp] = KeyBinding(
            label: "", action: .switchMode(ModeNames.emoji),
            category: .utility, returnAction: nil,
            accessibilityLabel: String(localized: "Emoji")
        )
        bindings[.swipeDown] = KeyBinding(
            label: "", action: .advanceToNextInputMode,
            category: .utility, returnAction: nil,
            accessibilityLabel: String(localized: "Switch keyboard")
        )
        return KeyConfig(
            id: GridSlot.r3c0, bindings: bindings,
            swipeMode: .twoWayVertical, slideType: .none,
            style: .utility, tapCycleActions: nil
        )
    }()

    /// Switches to the numeric mode (old symbols key, kept for numeric layer).
    static let symbols = KeyConfig.utility(
        UtilitySlot.symbols, label: "123", action: .switchMode(ModeNames.numeric),
        swipeMode: .eightWay,
        swipes: clipboardBindings,
        accessibilityLabel: String(localized: "Numbers")
    )

    /// Space bar with hold-for-digit.
    static func spacebar(zeroDigit: String = "0") -> KeyConfig {
        KeyConfig(
            id: UtilitySlot.space,
            bindings: [
                .tap: KeyBinding(
                    label: "␣", action: .space, category: .utility,
                    returnAction: nil, accessibilityLabel: String(localized: "Space")
                ),
                .longPress: KeyBinding(
                    label: zeroDigit, action: .commitText(zeroDigit),
                    category: .digit, returnAction: nil, accessibilityLabel: nil
                ),
            ],
            swipeMode: .none,
            slideType: .moveCursor,
            style: .spacebar,
            tapCycleActions: nil
        )
    }

    /// Cut-all, bound to both circle directions below.
    private static let cutAll = KeyBinding(
        label: "", action: .cutAll, category: .utility,
        returnAction: nil, accessibilityLabel: String(localized: "Cut all")
    )

    /// Clipboard bindings shared between the symbols key and numeric back-to-main key.
    static let clipboardBindings: [GestureType: KeyBinding] = [
        .swipeUp: KeyBinding(
            label: "", action: .copy, category: .utility,
            returnAction: nil, accessibilityLabel: String(localized: "Copy")
        ),
        .swipeUpRight: KeyBinding(
            label: "", action: .cut, category: .utility,
            returnAction: nil, accessibilityLabel: String(localized: "Cut")
        ),
        .swipeDown: KeyBinding(
            label: "", action: .paste, category: .utility,
            returnAction: nil, accessibilityLabel: String(localized: "Paste")
        ),
        .circularClockwise: cutAll,
        .circularCounterclockwise: cutAll,
    ]

    /// All utility keys as dictionary, mergeable with language keys.
    static let allUtilityKeys: [String: KeyConfig] = [
        UtilitySlot.clipboard: clipboard,
        UtilitySlot.autocomplete: autocomplete,
        UtilitySlot.delete: delete,
        UtilitySlot.return: `return`,
        UtilitySlot.symbols: symbols,
        UtilitySlot.space: spacebar(),
        GridSlot.r3c0: r3c0,
    ]

    // MARK: - Default Slot Bindings

    /// Default punctuation, symbol, compose, and action bindings for each grid slot.
    /// The factory merges these with language-specific center characters and
    /// directional overrides.
    ///
    /// Only `.swipeUp` and `.swipeDown` are defined (letter keys use
    /// `.twoWayVertical` swipe mode). Left, right, and diagonal swipes
    /// are removed from the letter grid.
    ///
    /// **Accessibility labels** follow the same convention as before: only
    /// sentence punctuation (, . ?) and the shift/capsLock affordance get
    /// named, because every named binding becomes a VoiceOver rotor entry.
    static let defaultSlotBindings: [String: [GestureType: KeyBinding]] = [
        // MARK: r0c0

        GridSlot.r0c0: [:],

        // MARK: r0c1

        GridSlot.r0c1: [:],

        // MARK: r0c2 — colon on swipeUp (symbol default, overridable per language)

        GridSlot.r0c2: [
            .swipeUp: KeyBinding(
                label: ":", action: .commitText(":"), category: nil,
                returnAction: .commitText(";"), accessibilityLabel: nil
            ),
        ],

        // MARK: r0c3

        GridSlot.r0c3: [:],

        // MARK: r1c0 — exclamation on swipeUp

        GridSlot.r1c0: [
            .swipeUp: KeyBinding(
                label: "!", action: .commitText("!"), category: nil,
                returnAction: .commitText("¡"), accessibilityLabel: nil
            ),
        ],

        // MARK: r1c1 — slash on swipeUp

        GridSlot.r1c1: [
            .swipeUp: KeyBinding(
                label: "/", action: .commitText("/"), category: nil,
                returnAction: .commitText("?"), accessibilityLabel: nil
            ),
        ],

        // MARK: r1c2 — hyphen on swipeUp

        GridSlot.r1c2: [
            .swipeUp: KeyBinding(
                label: "-", action: .commitText("-"), category: nil,
                returnAction: .commitText("—"), accessibilityLabel: nil
            ),
        ],

        // MARK: r1c3 — question mark on swipeUp (named)

        GridSlot.r1c3: [
            .swipeUp: KeyBinding(
                label: "?", action: .commitText("?"), category: nil,
                returnAction: .commitText("¿"),
                accessibilityLabel: String(localized: "Question mark")
            ),
        ],

        // MARK: r2c0 — shift on swipeUp

        GridSlot.r2c0: [
            .swipeUp: KeyBinding(
                label: "⇧", action: .switchMode(ModeNames.shifted), category: .modifier,
                returnAction: .capitalizeWord(uppercased: true),
                accessibilityLabel: String(localized: "Shift")
            ),
        ],

        // MARK: r2c1

        GridSlot.r2c1: [:],

        // MARK: r2c2 — apostrophe on swipeUp, comma on swipeDown

        GridSlot.r2c2: [
            .swipeUp: KeyBinding(
                label: "'", action: .commitText("'"), category: nil,
                returnAction: .commitText("\u{2019}"), accessibilityLabel: nil
            ),
            .swipeDown: KeyBinding(
                label: ",", action: .commitText(","), category: nil,
                returnAction: .commitText(","),
                accessibilityLabel: String(localized: "Comma")
            ),
        ],

        // MARK: r2c3 — quote on swipeUp, period on swipeDown

        GridSlot.r2c3: [
            .swipeUp: KeyBinding(
                label: "\"", action: .commitText("\""), category: nil,
                returnAction: .commitText("\u{201C}"), accessibilityLabel: nil
            ),
            .swipeDown: KeyBinding(
                label: ".", action: .commitText("."), category: nil,
                returnAction: .commitText("…"),
                accessibilityLabel: String(localized: "Period")
            ),
        ],
    ]
}