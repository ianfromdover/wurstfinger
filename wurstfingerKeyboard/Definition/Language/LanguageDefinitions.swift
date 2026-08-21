//
//  LanguageDefinitions.swift
//  Wurstfinger
//
//  All supported keyboard language definitions using GridKeyboardFactory.
//

import Foundation

/// All supported keyboard language definitions.
///
/// Each entry is a ``LanguageDescriptor``: its metadata (id/title/locale) is
/// available immediately, while the full `KeyboardDefinition` is built lazily
/// via `makeDefinition()`. The builder reuses the descriptor's metadata
/// (`meta.id`, …) so the id/title/locale live in exactly one place.
enum LanguageDefinitions {
    // MARK: - Croatian

    static let croatian = LanguageDescriptor(
        id: "hr_HR",
        title: "Hrvatski (Croatian)",
        localeIdentifier: "hr_HR"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["a", "n", "i", ""],
                ["h", "o", "r", ""],
                ["t", "e", "s", ""],
            ],
                        directionalOverrides: [
                GridSlot.r0c0: [
                    .swipeUp: "š",
                    .swipeDown: "đ",
                ],
                GridSlot.r0c1: [.swipeDown: "l"],
                GridSlot.r1c0: [
                    .swipeUp: "ć",
                    .swipeDown: "č",
                ],
                GridSlot.r1c1: [
                    .swipeUp: "u",
                    .swipeDown: "d",
                ],
                GridSlot.r2c0: [.swipeUp: "ž"],
                GridSlot.r2c1: [.swipeUp: "w"],
                GridSlot.r0c3: [.swipeUp: "v"],
                GridSlot.r1c3: [.swipeUp: "b"],
                GridSlot.r2c3: [.swipeUp: "f"],
            ]
        )
    }

        // MARK: - English

    static let english = LanguageDescriptor(
        id: "en_US",
        title: "English",
        localeIdentifier: "en_US"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["l", "d", "i", "o"],
                ["n", "t", "h", "c"],
                ["s", "r", "a", "e"],
            ],
            directionalOverrides: [
                GridSlot.r0c0: [.swipeUp: "v", .swipeDown: "w"],
                GridSlot.r0c1: [.swipeUp: "q", .swipeDown: "b"],
                GridSlot.r0c2: [.swipeUp: "-", .swipeDown: "x"],
                GridSlot.r0c3: [.swipeUp: "?", .swipeDown: "g"],
                GridSlot.r1c0: [.swipeDown: "f"],
                GridSlot.r1c1: [.swipeDown: "k"],
                GridSlot.r1c2: [.swipeUp: ":", .swipeDown: "u"],
                GridSlot.r1c3: [.swipeUp: "y", .swipeDown: "p"],
                GridSlot.r2c0: [.swipeDown: "z"],
                GridSlot.r2c1: [.swipeUp: "j", .swipeDown: "m"],
            ]
        )
    }// MARK: - Estonian-Finnish

    static let estonianFinnish = LanguageDescriptor(
        id: "et_EE",
        title: "Eesti-Suomi (Estonian-Finnish)",
        localeIdentifier: "et_EE"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["a", "n", "i", ""],
                ["h", "o", "r", ""],
                ["t", "e", "s", ""],
            ],
                        directionalOverrides: [
                GridSlot.r0c0: [
                    .swipeUp: "å",
                    .swipeDown: "ä",
                ],
                GridSlot.r0c1: [.swipeDown: "l"],
                GridSlot.r1c0: [
                    .swipeUp: "ö",
                    .swipeDown: "õ",
                ],
                GridSlot.r1c1: [
                    .swipeUp: "u",
                    .swipeDown: "d",
                ],
                GridSlot.r2c0: [.swipeUp: "ü"],
                GridSlot.r2c1: [.swipeUp: "w"],
                GridSlot.r0c3: [.swipeUp: "v"],
                GridSlot.r1c3: [.swipeUp: "b"],
                GridSlot.r2c3: [.swipeUp: "f"],
            ]
        )
    }

    // MARK: - Finnish

    static let finnish = LanguageDescriptor(
        id: "fi_FI",
        title: "Suomi (Finnish)",
        localeIdentifier: "fi_FI"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["a", "n", "i", ""],
                ["h", "o", "r", ""],
                ["t", "e", "s", ""],
            ],
                        directionalOverrides: [
                GridSlot.r0c0: [
                    .swipeUp: "å",
                    .swipeDown: "ä",
                ],
                GridSlot.r0c1: [.swipeDown: "l"],
                GridSlot.r1c0: [.swipeDown: "ö"],
                GridSlot.r1c1: [
                    .swipeUp: "u",
                    .swipeDown: "d",
                ],
                GridSlot.r2c1: [.swipeUp: "w"],
                GridSlot.r0c3: [.swipeUp: "v"],
                GridSlot.r1c3: [.swipeUp: "b"],
                GridSlot.r2c3: [.swipeUp: "f"],
            ]
        )
    }

    // MARK: - French

    static let french = LanguageDescriptor(
        id: "fr_FR",
        title: "Français (French)",
        localeIdentifier: "fr_FR"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["a", "n", "i", ""],
                ["u", "o", "r", ""],
                ["t", "e", "s", ""],
            ],
                        directionalOverrides: [
                GridSlot.r0c0: [.swipeDown: "â"],
                GridSlot.r0c1: [.swipeDown: "l"],
                GridSlot.r1c0: [
                    .swipeUp: "û",
                    .swipeDown: "ç",
                ],
                GridSlot.r1c1: [
                    .swipeUp: "h",
                    .swipeDown: "d",
                ],
                GridSlot.r2c0: [
                    .swipeUp: "ê",
                    .swipeDown: "ù",
                ],
                GridSlot.r2c1: [.swipeUp: "w"],
                GridSlot.r0c3: [.swipeUp: "v"],
                GridSlot.r1c3: [.swipeUp: "b"],
                GridSlot.r2c3: [.swipeUp: "f"],
            ]
        )
    }

    // MARK: - German

    static let german = LanguageDescriptor(
        id: "de_DE",
        title: "Deutsch (German)",
        localeIdentifier: "de_DE"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["a", "n", "i", ""],
                ["h", "d", "r", ""],
                ["t", "e", "s", ""],
            ],
                        directionalOverrides: [
                GridSlot.r0c0: [.swipeDown: "ä"],
                GridSlot.r0c1: [.swipeDown: "l"],
                GridSlot.r1c0: [
                    .swipeUp: "ü",
                    .swipeDown: "ö",
                ],
                GridSlot.r1c1: [
                    .swipeUp: "u",
                    .swipeDown: "o",
                ],
                GridSlot.r2c0: [.swipeDown: "ß"],
                GridSlot.r2c1: [.swipeUp: "w"],
                GridSlot.r0c3: [.swipeUp: "v"],
                GridSlot.r1c3: [.swipeUp: "b"],
                GridSlot.r2c3: [.swipeUp: "f"],
            ]
        )
    }

    // MARK: - Hebrew

    static let hebrew = LanguageDescriptor(
        id: "he_IL",
        title: "עברית (Hebrew)",
        localeIdentifier: "he_IL"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["ר", "ב", "א", ""],
                ["מ", "י", "ו", ""],
                ["ת", "ה", "ל", ""],
            ],
                        directionalOverrides: [
                GridSlot.r0c1: [.swipeDown: "ג"],
                GridSlot.r1c1: [
                    .swipeUp: "ח",
                    .swipeDown: "נ",
                ],
                GridSlot.r2c1: [.swipeUp: "ס"],
                GridSlot.r0c3: [.swipeUp: "v"],
                GridSlot.r1c3: [.swipeUp: "b"],
                GridSlot.r2c3: [.swipeUp: "f"],
            ],
            // MessagEase convention: a return swipe on a base letter produces
            // its final form (ן/ם additionally keep their dedicated swipes).
            // Hebrew is caseless: no shift key, no shifted/capsLock modes,
            // no auto-capitalization.
            supportsCapitalization: false,
            numericBackToAlphaLabel: "אבג"
        )
    }

    // MARK: - Italian

    static let italian = LanguageDescriptor(
        id: "it_IT",
        title: "Italiano (Italian)",
        localeIdentifier: "it_IT"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["a", "n", "i", ""],
                ["l", "o", "r", ""],
                ["t", "e", "s", ""],
            ],
                        directionalOverrides: [
                GridSlot.r0c1: [.swipeDown: "h"],
                GridSlot.r1c0: [
                    .swipeUp: "ù",
                    .swipeDown: "ò",
                ],
                GridSlot.r1c1: [
                    .swipeUp: "u",
                    .swipeDown: "d",
                ],
                GridSlot.r2c1: [.swipeUp: "w"],
                GridSlot.r0c3: [.swipeUp: "v"],
                GridSlot.r1c3: [.swipeUp: "b"],
                GridSlot.r2c3: [.swipeUp: "f"],
            ]
        )
    }

    // MARK: - Polish

    static let polish = LanguageDescriptor(
        id: "pl_PL",
        title: "Polski (Polish)",
        localeIdentifier: "pl_PL"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["a", "n", "i", ""],
                ["w", "o", "r", ""],
                ["z", "e", "s", ""],
            ],
                        directionalOverrides: [
                GridSlot.r0c0: [.swipeDown: "ą"],
                GridSlot.r0c1: [
                    .swipeUp: "ń",
                    .swipeDown: "l",
                ],
                GridSlot.r1c0: [
                    .swipeUp: "ó",
                    .swipeDown: "ć",
                ],
                GridSlot.r1c1: [
                    .swipeUp: "u",
                    .swipeDown: "d",
                ],
                GridSlot.r2c0: [.swipeDown: "ę"],
                GridSlot.r2c1: [.swipeUp: "h"],
                GridSlot.r0c3: [.swipeUp: "v"],
                GridSlot.r1c3: [.swipeUp: "b"],
                GridSlot.r2c3: [.swipeUp: "f"],
            ]
        )
    }

    // MARK: - Russian

    static let russian = LanguageDescriptor(
        id: "ru_RU",
        title: "Русский (Russian)",
        localeIdentifier: "ru_RU"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["с", "и", "т", ""],
                ["в", "о", "а", ""],
                ["е", "р", "н", ""],
            ],
                        directionalOverrides: [
                GridSlot.r0c0: [.swipeDown: "ц"],
                GridSlot.r0c1: [
                    .swipeUp: "й",
                    .swipeDown: "к",
                ],
                GridSlot.r1c0: [
                    .swipeUp: "б",
                    .swipeDown: "ъ",
                ],
                GridSlot.r1c1: [
                    .swipeUp: "м",
                    .swipeDown: "я",
                ],
                GridSlot.r2c0: [.swipeUp: "ё"],
                GridSlot.r2c1: [.swipeUp: "у"],
                GridSlot.r0c3: [.swipeUp: "v"],
                GridSlot.r1c3: [.swipeUp: "b"],
                GridSlot.r2c3: [.swipeUp: "f"],
            ],
            numericBackToAlphaLabel: "абв"
        )
    }

    // MARK: - Spanish-Catalan

    static let spanishCatalan = LanguageDescriptor(
        id: "ca_ES",
        title: "Español-Català (Spanish-Catalan)",
        localeIdentifier: "ca_ES"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["a", "n", "i", ""],
                ["d", "o", "r", ""],
                ["t", "e", "s", ""],
            ],
                        directionalOverrides: [
                GridSlot.r0c0: [
                    .swipeUp: "à",
                    .swipeDown: "á",
                ],
                GridSlot.r0c1: [
                    .swipeUp: "ñ",
                    .swipeDown: "l",
                ],
                GridSlot.r1c0: [
                    .swipeUp: "ü",
                    .swipeDown: "ç",
                ],
                GridSlot.r1c1: [
                    .swipeUp: "u",
                    .swipeDown: "h",
                ],
                GridSlot.r2c0: [
                    .swipeUp: "ú",
                    .swipeDown: "ó",
                ],
                GridSlot.r2c1: [.swipeUp: "w"],
                GridSlot.r0c3: [.swipeUp: "v"],
                GridSlot.r1c3: [.swipeUp: "b"],
                GridSlot.r2c3: [.swipeUp: "f"],
            ]
        )
    }

    // MARK: - Spanish

    static let spanish = LanguageDescriptor(
        id: "es_ES",
        title: "Español (Spanish)",
        localeIdentifier: "es_ES"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["a", "n", "i", ""],
                ["d", "o", "r", ""],
                ["t", "e", "s", ""],
            ],
                        directionalOverrides: [
                GridSlot.r0c0: [.swipeDown: "á"],
                GridSlot.r0c1: [
                    .swipeUp: "ñ",
                    .swipeDown: "l",
                ],
                GridSlot.r1c0: [.swipeUp: "ü"],
                GridSlot.r1c1: [
                    .swipeUp: "u",
                    .swipeDown: "h",
                ],
                GridSlot.r2c0: [
                    .swipeUp: "ú",
                    .swipeDown: "ó",
                ],
                GridSlot.r2c1: [.swipeUp: "w"],
                GridSlot.r0c3: [.swipeUp: "v"],
                GridSlot.r1c3: [.swipeUp: "b"],
                GridSlot.r2c3: [.swipeUp: "f"],
            ]
        )
    }

    // MARK: - Swedish

    static let swedish = LanguageDescriptor(
        id: "sv_SE",
        title: "Svenska (Swedish)",
        localeIdentifier: "sv_SE"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["a", "n", "i", ""],
                ["h", "d", "r", ""],
                ["t", "e", "s", ""],
            ],
                        directionalOverrides: [
                GridSlot.r0c0: [
                    .swipeUp: "å",
                    .swipeDown: "ä",
                ],
                GridSlot.r0c1: [.swipeDown: "l"],
                GridSlot.r1c0: [.swipeDown: "ö"],
                GridSlot.r1c1: [
                    .swipeUp: "u",
                    .swipeDown: "o",
                ],
                GridSlot.r2c1: [.swipeUp: "w"],
                GridSlot.r0c3: [.swipeUp: "v"],
                GridSlot.r1c3: [.swipeUp: "b"],
                GridSlot.r2c3: [.swipeUp: "f"],
            ]
        )
    }

    // MARK: - Tagalog

    static let tagalog = LanguageDescriptor(
        id: "tl_PH",
        title: "Tagalog (Filipino)",
        localeIdentifier: "tl_PH"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["a", "n", "i", ""],
                ["h", "o", "r", ""],
                ["t", "e", "s", ""],
            ],
                        directionalOverrides: [
                GridSlot.r0c1: [
                    .swipeUp: "ñ",
                    .swipeDown: "l",
                ],
                GridSlot.r1c1: [
                    .swipeUp: "u",
                    .swipeDown: "d",
                ],
                GridSlot.r2c1: [.swipeUp: "w"],
                GridSlot.r0c3: [.swipeUp: "v"],
                GridSlot.r1c3: [.swipeUp: "b"],
                GridSlot.r2c3: [.swipeUp: "f"],
            ]
        )
    }

    // MARK: - Vietnamese (Telex)

    static let vietnamese = LanguageDescriptor(
        id: "vi_VN",
        title: "Tiếng Việt (Vietnamese-Telex)",
        localeIdentifier: "vi_VN"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["a", "n", "i", ""],
                ["h", "o", "r", ""],
                ["t", "e", "s", ""],
            ],
                        directionalOverrides: [
                GridSlot.r0c0: [.swipeDown: "đ"],
                GridSlot.r0c1: [.swipeDown: "l"],
                GridSlot.r1c1: [
                    .swipeUp: "u",
                    .swipeDown: "d",
                ],
                GridSlot.r2c1: [.swipeUp: "w"],
                GridSlot.r0c3: [.swipeUp: "v"],
                GridSlot.r1c3: [.swipeUp: "b"],
                GridSlot.r2c3: [.swipeUp: "f"],
            ],
            inputMethod: .telex
        )
    }
}
