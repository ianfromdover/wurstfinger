//
//  NumericLayouts.swift
//  Wurstfinger
//
//  Numeric keyboard modes (phone and classic digit ordering).
//  Swipe bindings are inherited from CommonKeys.defaultSlotBindings so that
//  the numeric layer has the same punctuation layout as the letter layer.
//

import Foundation

/// Numeric keyboard modes shared across all languages.
enum NumericLayouts {
    /// Digit slots in a 3×3 grid that maps to columns 1–3 of the 4×5 numeric
    /// arrangement. Column 0 is blank (spacer slots).
    private static let digitSlotRows: [[String]] = [
        ["n01", "n02", "n03"],
        ["n11", "n12", "n13"],
        ["n21", "n22", "n23"],
    ]

    /// Spacer slots for the blank leftmost column.
    private static let blankSlots: [String] = ["n00", "n10", "n20"]

    /// Default Latin label for the back-to-alpha key. Languages whose
    /// alphabet is not Latin (Hebrew, Russian, …) should pass their own
    /// script-appropriate label via `phone(backToAlphaLabel:)`.
    static let defaultBackToAlphaLabel = "ABC"

    /// Western (ASCII) digits, indexed by value 0–9. The default digit set.
    static let westernDigits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

    /// Arabic-Indic digits (U+0660–0669), used by the Arabic layout.
    static let arabicIndicDigits = ["٠", "١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩"]

    /// Extended Arabic-Indic (Persian) digits (U+06F0–06F9), used by the
    /// Persian and Urdu layouts.
    static let persianDigits = ["۰", "۱", "۲", "۳", "۴", "۵", "۶", "۷", "۸", "۹"]

    /// Thai digits (U+0E50–0E59), used by the Thai layout.
    static let thaiDigits = ["๐", "๑", "๒", "๓", "๔", "๕", "๖", "๗", "๘", "๙"]

    /// Devanagari digits (U+0966–096F), used by the Hindi layout.
    static let devanagariDigits = ["०", "१", "२", "३", "४", "५", "६", "७", "८", "९"]

    /// Phone-style layout (1-2-3 in top row).
    ///
    /// - Parameter digits: Digit set indexed by value (0–9). Non-Latin layouts
    ///   (Arabic, Persian, …) pass their script-specific digits; both the tap
    ///   output and the key label use the supplied glyphs.
    static func phone(
        digits: [String] = westernDigits,
        backToAlphaLabel: String = defaultBackToAlphaLabel
    ) -> KeyboardMode {
        precondition(digits.count == 10, "digits must contain exactly 10 glyphs (values 0–9)")
        return buildMode(
            centerDigits: [
                [digits[1], digits[2], digits[3]],
                [digits[4], digits[5], digits[6]],
                [digits[7], digits[8], digits[9]],
            ],
            zeroDigit: digits[0],
            // Phone layout swaps digits but keeps circular gestures at their
            // physical positions.
            circularOverrides: phoneCircularOverrides,
            backToAlphaLabel: backToAlphaLabel
        )
    }

    /// Classic calculator style (7-8-9 in top row).
    static func classic(
        digits: [String] = westernDigits,
        backToAlphaLabel: String = defaultBackToAlphaLabel
    ) -> KeyboardMode {
        precondition(digits.count == 10, "digits must contain exactly 10 glyphs (values 0–9)")
        return buildMode(
            centerDigits: [
                [digits[7], digits[8], digits[9]],
                [digits[4], digits[5], digits[6]],
                [digits[1], digits[2], digits[3]],
            ],
            zeroDigit: digits[0],
            circularOverrides: classicCircularOverrides,
            backToAlphaLabel: backToAlphaLabel
        )
    }

    // MARK: - Numeric Utility Keys

    /// Switches back to the main (alphabetic) mode. The label is the script's
    /// first letters ("abc", "абв", "कखग"), which VoiceOver spells out or reads
    /// as a nonsense word, so the tap carries a semantic name that is the same in
    /// every layout — the counterpart to `CommonKeys.symbols`, named "Numbers".
    private static func backToMain(label: String) -> KeyConfig {
        KeyConfig.utility(
            UtilitySlot.symbols, label: label, action: .switchMode(ModeNames.main),
            swipeMode: .eightWay,
            swipes: CommonKeys.clipboardBindings,
            accessibilityLabel: String(localized: "Letters")
        )
    }

    /// Standalone "0" digit key in the bottom row.
    private static func zeroKey(digit: String) -> KeyConfig {
        KeyConfig(
            id: GridSlot.zero,
            bindings: [
                // Tap only. A hold on a letter key reaches this digit via
                // `GhostKeyResolver`, which maps a `.longPress` to the fallback
                // key's `.tap` when that tap emits a digit — so the numeric
                // layer no longer mirrors every digit as an explicit long press.
                .tap: KeyBinding(
                    label: digit, action: .commitText(digit),
                    category: .digit, returnAction: nil, accessibilityLabel: nil
                ),
            ],
            swipeMode: .none,
            slideType: .none,
            style: .primary,
            tapCycleActions: nil
        )
    }

    private static func utilityKeys(zeroDigit: String, backToAlphaLabel: String) -> [String: KeyConfig] {
        [
            UtilitySlot.clipboard: CommonKeys.clipboard,
            UtilitySlot.delete: CommonKeys.delete,
            UtilitySlot.return: CommonKeys.return,
            UtilitySlot.symbols: backToMain(label: backToAlphaLabel),
            UtilitySlot.space: CommonKeys.spacebar(zeroDigit: zeroDigit),
            GridSlot.zero: zeroKey(digit: zeroDigit),
        ]
    }

    // MARK: - Numeric-Specific Overrides

    /// Extra swipe bindings that only appear on the numeric layer
    /// (beyond what CommonKeys.defaultSlotBindings provides).
    private static let numericExtraSwipes: [String: [GestureType: KeyBinding]] = [
        GridSlot.topLeft: [
            .swipeLeft: KeyBinding(
                label: "≤", action: .commitText("≤"), category: nil,
                returnAction: nil, accessibilityLabel: nil
            ),
        ],
        GridSlot.topRight: [
            .swipeRight: KeyBinding(
                label: "≥", action: .commitText("≥"), category: nil,
                returnAction: nil, accessibilityLabel: nil
            ),
        ],
    ]

    // MARK: - Circular Gestures

    /// Circular gesture bindings for the classic (7-8-9) layout.
    /// Both directions produce the same symbol.
    private static let classicCircularOverrides: [String: KeyBinding] = [
        digitSlotRows[0][0]: KeyBinding(
            label: "∫", action: .commitText("∫"), category: nil,
            returnAction: nil, accessibilityLabel: nil
        ),
        digitSlotRows[0][1]: KeyBinding(
            label: "∏", action: .commitText("∏"), category: nil,
            returnAction: nil, accessibilityLabel: nil
        ),
        digitSlotRows[0][2]: KeyBinding(
            label: "∑", action: .commitText("∑"), category: nil,
            returnAction: nil, accessibilityLabel: nil
        ),
        digitSlotRows[1][0]: KeyBinding(
            label: "¼", action: .commitText("¼"), category: nil,
            returnAction: nil, accessibilityLabel: nil
        ),
        digitSlotRows[1][1]: KeyBinding(
            label: "a", action: .commitText("a"), category: nil,
            returnAction: nil, accessibilityLabel: nil
        ),
        digitSlotRows[1][2]: KeyBinding(
            label: "ⁿ", action: .commitText("ⁿ"), category: nil,
            returnAction: nil, accessibilityLabel: nil
        ),
        digitSlotRows[2][0]: KeyBinding(
            label: "¹", action: .commitText("¹"), category: nil,
            returnAction: nil, accessibilityLabel: nil
        ),
        digitSlotRows[2][1]: KeyBinding(
            label: "²", action: .commitText("²"), category: nil,
            returnAction: nil, accessibilityLabel: nil
        ),
        digitSlotRows[2][2]: KeyBinding(
            label: "³", action: .commitText("³"), category: nil,
            returnAction: nil, accessibilityLabel: nil
        ),
    ]

    /// Phone layout: digits 1-2-3 sit in the top row (physical position of
    /// 7-8-9 in classic), so circular gestures follow the digit, not the
    /// position, not the grid slot. The top and bottom rows therefore swap
    /// their classic bindings; the middle row is unchanged.
    private static let phoneCircularOverrides: [String: KeyBinding] = {
        let slotRemap: [String: String] = [
            // Top row pulls from the classic bottom row, and vice versa.
            digitSlotRows[0][0]: digitSlotRows[2][0],
            digitSlotRows[0][1]: digitSlotRows[2][1],
            digitSlotRows[0][2]: digitSlotRows[2][2],
            digitSlotRows[1][0]: digitSlotRows[1][0],
            digitSlotRows[1][1]: digitSlotRows[1][1],
            digitSlotRows[1][2]: digitSlotRows[1][2],
            digitSlotRows[2][0]: digitSlotRows[0][0],
            digitSlotRows[2][1]: digitSlotRows[0][1],
            digitSlotRows[2][2]: digitSlotRows[0][2],
        ]
        return slotRemap.reduce(into: [:]) { result, pair in
            result[pair.key] = classicCircularOverrides[pair.value]
        }
    }()

    // MARK: - Builder

    /// Blank key for the leftmost column spacer.
    private static func blank(keyId: String) -> KeyConfig {
        KeyConfig(
            id: keyId,
            bindings: [.tap: KeyBinding(
                label: "", action: .none, category: .utility,
                returnAction: nil, accessibilityLabel: nil
            )],
            swipeMode: .none,
            slideType: .none,
            style: .utility,
            tapCycleActions: nil
        )
    }

    private static func buildMode(
        centerDigits: [[String]],
        zeroDigit: String,
        circularOverrides: [String: KeyBinding],
        backToAlphaLabel: String
    ) -> KeyboardMode {
        precondition(
            centerDigits.count == 3 && centerDigits.allSatisfy { $0.count == 3 },
            "centerDigits must be a 3×3 matrix"
        )
        var digitKeys: [String: KeyConfig] = [:]

        // Blank leftmost column (column 0 of the 4×5 grid)
        for slotId in blankSlots {
            digitKeys[slotId] = blank(keyId: slotId)
        }

        for (rowIdx, row) in centerDigits.enumerated() {
            for (colIdx, digit) in row.enumerated() {
                let slotId = digitSlotRows[rowIdx][colIdx]

                // Start with shared punctuation defaults (same as letter layer),
                // but remove shift/capsLock bindings that don't apply to numeric.
                // Uses the new slot name — no legacy defaults are inherited.

                // Add circular gesture bindings
                var bindings: [GestureType: KeyBinding] = [:]
                if let circBinding = circularOverrides[slotId] {
                    bindings[.circularClockwise] = circBinding
                    bindings[.circularCounterclockwise] = circBinding
                }

                // Tap → digit. `GhostKeyResolver` falls back to this layer for
                // gestures the letter layer leaves unbound; for a `.longPress`
                // it maps to this `.digit` tap, so holding a letter key types
                // its digit without a mode switch and without mirroring the tap
                // as an explicit long-press binding. Long presses only occur
                // with the opt-in "Type Numbers by Holding" setting enabled.
                bindings[.tap] = KeyBinding(
                    label: digit, action: .commitText(digit),
                    category: .digit, returnAction: nil, accessibilityLabel: nil
                )

                digitKeys[slotId] = KeyConfig(
                    id: slotId, bindings: bindings, swipeMode: .eightWay,
                    slideType: .none, style: .primary, tapCycleActions: nil
                )
            }
        }

        let utilities = utilityKeys(zeroDigit: zeroDigit, backToAlphaLabel: backToAlphaLabel)
        precondition(
            Set(digitKeys.keys).isDisjoint(with: utilities.keys),
            "digit and utility key IDs must not overlap"
        )
        let allKeys = digitKeys.merging(utilities) { digit, _ in digit }

        return KeyboardMode(
            name: ModeNames.numeric,
            keys: allKeys,
            arrangements: StandardArrangements.numeric4x5,
            autoTransitions: [:]
        )
    }
}
