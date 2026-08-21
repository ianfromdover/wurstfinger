//
//  StandardArrangements.swift
//  Wurstfinger
//
//  Standard grid arrangements for 4-column swipe keyboard layouts.
//

import Foundation

/// Standard grid arrangements for the 4-column grid layout.
/// Shared across all languages using the same 4×3 letter + 1 bottom-row + utility structure.
enum StandardArrangements {
    // MARK: - Portrait

    private static let portrait = GridArrangement(
        columns: 5,
        rows: [
            [.init(keyId: GridSlot.r0c0), .init(keyId: GridSlot.r0c1), .init(keyId: GridSlot.r0c2), .init(keyId: GridSlot.r0c3), .init(keyId: UtilitySlot.clipboard)],
            [.init(keyId: GridSlot.r1c0), .init(keyId: GridSlot.r1c1), .init(keyId: GridSlot.r1c2), .init(keyId: GridSlot.r1c3), .init(keyId: UtilitySlot.autocomplete)],
            [.init(keyId: GridSlot.r2c0), .init(keyId: GridSlot.r2c1), .init(keyId: GridSlot.r2c2), .init(keyId: GridSlot.r2c3), .init(keyId: UtilitySlot.delete)],
            [.init(keyId: GridSlot.r3c0), .init(keyId: UtilitySlot.space, widthMultiplier: 3), .init(keyId: UtilitySlot.return)],
        ]
    )

    // MARK: - Landscape

    /// Landscape: utility keys on the leading (left) edge.
    private static let landscape = GridArrangement(
        columns: 5,
        rows: [
            [.init(keyId: UtilitySlot.clipboard), .init(keyId: GridSlot.r0c0), .init(keyId: GridSlot.r0c1), .init(keyId: GridSlot.r0c2), .init(keyId: GridSlot.r0c3)],
            [.init(keyId: UtilitySlot.autocomplete), .init(keyId: GridSlot.r1c0), .init(keyId: GridSlot.r1c1), .init(keyId: GridSlot.r1c2), .init(keyId: GridSlot.r1c3)],
            [.init(keyId: UtilitySlot.delete), .init(keyId: GridSlot.r2c0), .init(keyId: GridSlot.r2c1), .init(keyId: GridSlot.r2c2), .init(keyId: GridSlot.r2c3)],
            [.init(keyId: UtilitySlot.return), .init(keyId: GridSlot.r3c0), .init(keyId: UtilitySlot.space, widthMultiplier: 3)],
        ]
    )

    // MARK: - Numeric Portrait

    /// Numeric mode portrait: 4 rows × 5 columns with blank left column,
    /// digits in columns 1–3, utility column on the right.
    private static let numericPortrait = GridArrangement(
        columns: 5,
        rows: [
            [.init(keyId: "n00"), .init(keyId: "n01"), .init(keyId: "n02"), .init(keyId: "n03"), .init(keyId: UtilitySlot.clipboard)],
            [.init(keyId: "n10"), .init(keyId: "n11"), .init(keyId: "n12"), .init(keyId: "n13"), .init(keyId: UtilitySlot.symbols)],
            [.init(keyId: "n20"), .init(keyId: "n21"), .init(keyId: "n22"), .init(keyId: "n23"), .init(keyId: UtilitySlot.delete)],
            [.init(keyId: GridSlot.zero), .init(keyId: UtilitySlot.space, widthMultiplier: 3), .init(keyId: UtilitySlot.return)],
        ]
    )

    // MARK: - Numeric Landscape

    private static let numericLandscape = GridArrangement(
        columns: 5,
        rows: [
            [.init(keyId: UtilitySlot.clipboard), .init(keyId: "n00"), .init(keyId: "n01"), .init(keyId: "n02"), .init(keyId: "n03")],
            [.init(keyId: UtilitySlot.symbols), .init(keyId: "n10"), .init(keyId: "n11"), .init(keyId: "n12"), .init(keyId: "n13")],
            [.init(keyId: UtilitySlot.delete), .init(keyId: "n20"), .init(keyId: "n21"), .init(keyId: "n22"), .init(keyId: "n23")],
            [.init(keyId: UtilitySlot.return), .init(keyId: GridSlot.zero), .init(keyId: UtilitySlot.space, widthMultiplier: 3)],
        ]
    )

    // MARK: - Utility-Left Variants

    /// The utility keys that move to the leading edge when "Utility Keys on
    /// Left" is enabled: clipboard, autocomplete, delete, and return — in the same
    /// top-to-bottom order as the trailing column. The space bar and all
    /// letter/digit keys keep their original left-to-right order.
    static let leadingUtilityKeys: Set<String> = [
        UtilitySlot.clipboard, UtilitySlot.autocomplete, UtilitySlot.delete, UtilitySlot.return,
    ]

    private static func utilityLeft(_ arrangement: GridArrangement) -> GridArrangement {
        arrangement.movingToLeading(keyIds: leadingUtilityKeys)
    }

    /// Utility-left variant for the numeric keyboard.
    private static let numericLeadingUtilityKeys: Set<String> = [
        UtilitySlot.clipboard, UtilitySlot.symbols, UtilitySlot.delete, UtilitySlot.return,
    ]

    private static func numericUtilityLeft(_ arrangement: GridArrangement) -> GridArrangement {
        arrangement.movingToLeading(keyIds: numericLeadingUtilityKeys)
    }

    // MARK: - All 4 Contexts

    /// All 4 arrangement contexts for the 4-column letter grid.
    static let grid3x3: [ArrangementContext: GridArrangement] = [
        .portrait: portrait,
        .portraitUtilityLeft: utilityLeft(portrait),
        .landscape: landscape,
        .landscapeUtilityLeft: utilityLeft(landscape),
    ]

    /// Numeric mode arrangements.
    static let numeric4x5: [ArrangementContext: GridArrangement] = [
        .portrait: numericPortrait,
        .portraitUtilityLeft: numericUtilityLeft(numericPortrait),
        .landscape: numericLandscape,
        .landscapeUtilityLeft: numericUtilityLeft(numericLandscape),
    ]
}