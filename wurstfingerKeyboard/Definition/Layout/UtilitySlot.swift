//
//  UtilitySlot.swift
//  Wurstfinger
//
//  Utility key slot names (independent of layout family).
//

import Foundation

/// Utility keys have functional names (independent of layout family).
enum UtilitySlot {
    static let globe = "globe"
    static let delete = "delete"
    static let `return` = "return"
    static let space = "space"
    static let symbols = "symbols"
    /// Clipboard key: Copy (swipeUp) / Cut (tap) / Paste (swipeDown)
    static let clipboard = "clipboard"
    /// Autocomplete key: tap types "auto" (hardcoded MVP)
    static let autocomplete = "autocomplete"
}
