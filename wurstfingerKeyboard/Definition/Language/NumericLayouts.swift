//
//  NumericLayouts.swift
//  Wurstfinger
//
//  4×5 numeric/symbol layer matching the Wurstfinger Duo layout spec.
//  Column 0 holds symbols, columns 1–3 hold digits + associated symbols,
//  column 4 is the shared utility column (clipboard, autocomplete, delete, return).
//

import Foundation

/// Numeric keyboard mode built from a fixed 4×5 grid of symbol and digit keys.
enum NumericLayouts {
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

    /// Fixed 4×5 numeric layer.
    ///
    /// Row 0: symbols - 1 2 3
    /// Row 1: symbols = 4 5 6
    /// Row 2: symbols . 7 8 9
    /// Row 3: abc  0  space space  return
    ///
    /// Column 4 holds shared utility keys (clipboard, autocomplete, delete, return).
    static func phone(
        digits: [String] = westernDigits,
        backToAlphaLabel: String = defaultBackToAlphaLabel
    ) -> KeyboardMode {
        precondition(digits.count == 10, "digits must contain exactly 10 glyphs (values 0–9)")
        let d = digits
        var keys: [String: KeyConfig] = [:]

        // ── Row 0 ──────────────────────────────────────────────
        keys["n0c0"] = verticalKey(id: "n0c0", tap: "-", swipeUp: "`", swipeDown: "_")
        keys["n0c1"] = verticalKey(id: "n0c1", tap: d[1], swipeUp: "<", swipeDown: "!", category: .digit)
        keys["n0c2"] = verticalKey(id: "n0c2", tap: d[2], swipeUp: ">", swipeDown: "@", category: .digit)
        keys["n0c3"] = verticalKey(id: "n0c3", tap: d[3], swipeUp: "|", swipeDown: "#", category: .digit)

        // ── Row 1 ──────────────────────────────────────────────
        keys["n1c0"] = verticalKey(id: "n1c0", tap: "=", swipeUp: "[", swipeDown: "+")
        keys["n1c1"] = verticalKey(id: "n1c1", tap: d[4], swipeUp: "]", swipeDown: "$", category: .digit)
        keys["n1c2"] = verticalKey(id: "n1c2", tap: d[5], swipeUp: "(", swipeDown: "%", category: .digit)
        keys["n1c3"] = verticalKey(id: "n1c3", tap: d[6], swipeUp: ")", swipeDown: "^", category: .digit)

        // ── Row 2 ──────────────────────────────────────────────
        keys["n2c0"] = KeyConfig(
            id: "n2c0",
            bindings: [
                .tap: KeyBinding(label: ".", action: .commitText("."), category: nil, returnAction: nil, accessibilityLabel: String(localized: "Period")),
                .swipeUp: KeyBinding(label: "⇧", action: .switchMode(ModeNames.shifted), category: .modifier, returnAction: nil, accessibilityLabel: String(localized: "Shift")),
                .swipeDown: KeyBinding(label: "•", action: .commitText("•"), category: nil, returnAction: nil, accessibilityLabel: nil),
            ],
            swipeMode: .twoWayVertical,
            slideType: .none,
            style: .primary,
            tapCycleActions: nil
        )
        keys["n2c1"] = verticalKey(id: "n2c1", tap: d[7], swipeUp: "{", swipeDown: "&", category: .digit)
        keys["n2c2"] = verticalKey(id: "n2c2", tap: d[8], swipeUp: "}", swipeDown: "*", category: .digit)
        keys["n2c3"] = verticalKey(id: "n2c3", tap: d[9], swipeUp: ";", swipeDown: "/", category: .digit)

        // ── Row 3 ──────────────────────────────────────────────
        // Back-to-alpha key (abc / emoji / globe)
        keys["n3c0"] = KeyConfig(
            id: "n3c0",
            bindings: [
                .tap: KeyBinding(label: backToAlphaLabel, action: .switchMode(ModeNames.main), category: .utility, returnAction: nil, accessibilityLabel: String(localized: "Letters")),
                .swipeUp: KeyBinding(label: "", action: .switchMode(ModeNames.emoji), category: .utility, returnAction: nil, accessibilityLabel: String(localized: "Emoji")),
                .swipeDown: KeyBinding(label: "", action: .advanceToNextInputMode, category: .utility, returnAction: nil, accessibilityLabel: String(localized: "Switch keyboard")),
            ],
            swipeMode: .twoWayVertical,
            slideType: .none,
            style: .utility,
            tapCycleActions: nil
        )
        // Zero key with colon / backslash swipes
        keys["n3c1"] = verticalKey(id: "n3c1", tap: d[0], swipeUp: ":", swipeDown: "\\", category: .digit)

        // ── Utility column & space ─────────────────────────────
        keys[UtilitySlot.clipboard] = CommonKeys.clipboard
        keys[UtilitySlot.autocomplete] = CommonKeys.autocomplete
        keys[UtilitySlot.delete] = CommonKeys.delete
        keys[UtilitySlot.return] = CommonKeys.return
        keys[UtilitySlot.space] = CommonKeys.spacebar(zeroDigit: d[0])

        // ── Coordinate slot aliases for GhostKeyResolver ────────
        // The resolver looks up the letter grid's coordinate slot ID
        // (e.g. "r0c1") in the numeric fallback mode. Since the numeric
        // layer uses its own nXcY naming, alias each coordinate to its
        // digit so long-press digit fallback works. The resolver only uses
        // the tap when it has category == .digit, so non-digit slots
        // (column 0 symbols, abc, space) are safely ignored.
        let digitAliases: [(String, Int)] = [
            (GridSlot.r0c1, 1), (GridSlot.r0c2, 2), (GridSlot.r0c3, 3),
            (GridSlot.r1c1, 4), (GridSlot.r1c2, 5), (GridSlot.r1c3, 6),
            (GridSlot.r2c1, 7), (GridSlot.r2c2, 8), (GridSlot.r2c3, 9),
            (GridSlot.r3c1, 0),
        ]
        for (slot, digitIndex) in digitAliases {
            keys[slot] = legacyDigitKey(id: slot, digit: d[digitIndex])
        }

        // Legacy 3×3 names kept for test compatibility.
        keys[GridSlot.topLeft] = legacyDigitKey(id: GridSlot.topLeft, digit: d[1])
        keys[GridSlot.topCenter] = legacyDigitKey(id: GridSlot.topCenter, digit: d[2])
        keys[GridSlot.topRight] = legacyDigitKey(id: GridSlot.topRight, digit: d[3])
        keys[GridSlot.midLeft] = legacyDigitKey(id: GridSlot.midLeft, digit: d[4])
        keys[GridSlot.center] = legacyDigitKey(id: GridSlot.center, digit: d[5])
        keys[GridSlot.midRight] = legacyDigitKey(id: GridSlot.midRight, digit: d[6])
        keys[GridSlot.bottomLeft] = legacyDigitKey(id: GridSlot.bottomLeft, digit: d[7])
        keys[GridSlot.bottomCenter] = legacyDigitKey(id: GridSlot.bottomCenter, digit: d[8])
        keys[GridSlot.bottomRight] = legacyDigitKey(id: GridSlot.bottomRight, digit: d[9])
        keys[GridSlot.zero] = legacyDigitKey(id: GridSlot.zero, digit: d[0])

        return KeyboardMode(
            name: ModeNames.numeric,
            keys: keys,
            arrangements: StandardArrangements.numeric4x5,
            autoTransitions: [:]
        )
    }

    /// Classic-style layout — produces the same 4×5 layout as `phone()`
    /// since the symbol assignments are tied to physical grid positions.
    static func classic(
        digits: [String] = westernDigits,
        backToAlphaLabel: String = defaultBackToAlphaLabel
    ) -> KeyboardMode {
        phone(digits: digits, backToAlphaLabel: backToAlphaLabel)
    }

    // MARK: - Internals

    /// Builds a key with tap + vertical swipe bindings.
    private static func verticalKey(
        id: String,
        tap: String,
        swipeUp: String,
        swipeDown: String,
        category: KeyCategory? = nil
    ) -> KeyConfig {
        KeyConfig(
            id: id,
            bindings: [
                .tap: KeyBinding(label: tap, action: .commitText(tap), category: category, returnAction: nil, accessibilityLabel: nil),
                .swipeUp: KeyBinding(label: swipeUp, action: .commitText(swipeUp), category: nil, returnAction: nil, accessibilityLabel: nil),
                .swipeDown: KeyBinding(label: swipeDown, action: .commitText(swipeDown), category: nil, returnAction: nil, accessibilityLabel: nil),
            ],
            swipeMode: .twoWayVertical,
            slideType: .none,
            style: .primary,
            tapCycleActions: nil
        )
    }

    /// Tap-only digit key used as a GhostKeyResolver alias.
    private static func legacyDigitKey(id: String, digit: String) -> KeyConfig {
        KeyConfig(
            id: id,
            bindings: [
                .tap: KeyBinding(label: digit, action: .commitText(digit), category: .digit, returnAction: nil, accessibilityLabel: nil),
            ],
            swipeMode: .none,
            slideType: .none,
            style: .primary,
            tapCycleActions: nil
        )
    }
}