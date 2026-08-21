//
//  GridSlot.swift
//  Wurstfinger
//
//  Coordinate-based slot names for 4-column grid layouts.
//

import Foundation

/// Coordinate-based slot names for a 4×4 grid layout plus the legacy 3×3
/// slots kept for NumericLayouts compatibility.
enum GridSlot {
    // MARK: - New 4-column letter slots

    static let r0c0 = "r0c0"
    static let r0c1 = "r0c1"
    static let r0c2 = "r0c2"
    static let r0c3 = "r0c3"
    static let r1c0 = "r1c0"
    static let r1c1 = "r1c1"
    static let r1c2 = "r1c2"
    static let r1c3 = "r1c3"
    static let r2c0 = "r2c0"
    static let r2c1 = "r2c1"
    static let r2c2 = "r2c2"
    static let r2c3 = "r2c3"

    /// Bottom-row special keys (leftmost key and spacebar region)
    static let r3c0 = "r3c0"
    static let r3c1 = "r3c1"
    static let r3c2 = "r3c2"
    static let r3c3 = "r3c3"

    // MARK: - Legacy names (kept for NumericLayouts compatibility)

    static let topLeft = "topLeft"
    static let topCenter = "topCenter"
    static let topRight = "topRight"
    static let midLeft = "midLeft"
    static let center = "center"
    static let midRight = "midRight"
    static let bottomLeft = "bottomLeft"
    static let bottomCenter = "bottomCenter"
    static let bottomRight = "bottomRight"

    /// Extra slot for the "0" digit key (only used in numeric mode).
    static let zero = "zero"

    /// Ordered list of all legacy slots (3×3, for NumericLayouts compatibility).
    static let allSlots: [[String]] = [
        [topLeft, topCenter, topRight],
        [midLeft, center, midRight],
        [bottomLeft, bottomCenter, bottomRight],
    ]

    /// Ordered list of letter slots (3 rows × 4 columns), used by
    /// `GridKeyboardFactory` to build letter keys.
    static let letterSlots: [[String]] = [
        [r0c0, r0c1, r0c2, r0c3],
        [r1c0, r1c1, r1c2, r1c3],
        [r2c0, r2c1, r2c2, r2c3],
    ]
}