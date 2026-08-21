// MARK: - Additional MessagEase Layouts

/// Layouts ported 1:1 from the decompiled MessagEase reference. Kept in a
/// separate extension so the primary `LanguageDefinitions` body stays within
/// SwiftLint's `type_body_length` limit.
extension LanguageDefinitions {
    // MARK: Ukrainian

    /// Ukrainian reuses the Russian Cyrillic layout with MessagEase's four
    /// letter substitutions (ъёэы → ґїєі), matching the decompiled reference.
    static let ukrainian = LanguageDescriptor(
        id: "uk_UA",
        title: "Українська (Ukrainian)",
        localeIdentifier: "uk_UA"
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
                    .swipeDown: "ґ",
                ],
                GridSlot.r1c1: [
                    .swipeUp: "м",
                    .swipeDown: "я",
                ],
                GridSlot.r2c0: [.swipeUp: "ї"],
                GridSlot.r2c1: [.swipeUp: "у"],
                GridSlot.r0c3: [.swipeUp: "п"],
                GridSlot.r1c3: [.swipeUp: "щ"],
                GridSlot.r2c3: [.swipeUp: "є"],
            ],
            numericBackToAlphaLabel: "абв"
        )
    }

    // MARK: Greek

    static let greek = LanguageDescriptor(
        id: "el_GR",
        title: "Ελληνικά (Greek)",
        localeIdentifier: "el_GR"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["α", "ν", "ι", ""],
                ["η", "ο", "ρ", ""],
                ["τ", "ε", "σ", ""],
            ],
            // MessagEase's generic Latin accent ring (ô â ä í î ç ø é ü) is
            // dropped here: it is noise on a Greek keyboard and would override
            // the default punctuation/symbol swipes. Greek tonos/dialytika
            // belong in compose rules, not as primary swipes.
                        directionalOverrides: [
                GridSlot.r0c1: [.swipeDown: "λ"],
                GridSlot.r1c1: [
                    .swipeUp: "υ",
                    .swipeDown: "δ",
                ],
                GridSlot.r2c1: [.swipeUp: "ω"],
                GridSlot.r0c3: [.swipeUp: "ω"],
                GridSlot.r1c3: [.swipeUp: "ξ"],
                GridSlot.r2c3: [.swipeUp: "φ"],
            ],
            numericBackToAlphaLabel: "αβγ"
        )
    }

    // MARK: Portuguese

    static let portuguese = LanguageDescriptor(
        id: "pt_PT",
        title: "Português (Portuguese)",
        localeIdentifier: "pt_PT"
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
                    .swipeUp: "ô",
                    .swipeDown: "á",
                ],
                GridSlot.r0c1: [.swipeDown: "l"],
                GridSlot.r1c0: [.swipeDown: "ç"],
                GridSlot.r1c1: [
                    .swipeUp: "u",
                    .swipeDown: "h",
                ],
                GridSlot.r2c0: [
                    .swipeUp: "ú",
                    .swipeDown: "ó",
                ],
                GridSlot.r2c1: [.swipeUp: "w"],
                GridSlot.r0c3: [.swipeUp: "â"],
                GridSlot.r1c3: [.swipeUp: "m"],
                GridSlot.r2c3: [.swipeUp: "z"],
            ]
        )
    }

    // MARK: Arabic script (RTL)

    static let arabic = LanguageDescriptor(
        id: "ar",
        title: "العربية (Arabic)",
        localeIdentifier: "ar"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["ه", "ب", "م", ""],
                ["ي", "ا", "ر", ""],
                ["و", "ن", "د", ""],
            ],
            directionalOverrides: ScriptPunctuation.arabicScript(adding: [
                GridSlot.topLeft: [.swipeRight: "ـ", .swipeDown: "ة", .swipeDownRight: "ق"],
                GridSlot.topCenter: [
                    .swipeUp: "ُ", .swipeUpLeft: "ِ", .swipeUpRight: "َ",
                    .swipeDown: "خ", .swipeDownLeft: "ض",
                ],
                GridSlot.topRight: [.swipeDownLeft: "إ"],
                GridSlot.midLeft: [
                    .swipeUpRight: "ص", .swipeRight: "ح", .swipeDown: "ى",
                    .swipeDownRight: "ط",
                ],
                GridSlot.center: [
                    .swipeUp: "ج", .swipeUpLeft: "ف", .swipeUpRight: "ش",
                    .swipeLeft: "س", .swipeRight: "آ", .swipeDown: "ت",
                    .swipeDownLeft: "ل", .swipeDownRight: "ك",
                ],
                GridSlot.midRight: [.swipeUpLeft: "ٰ", .swipeLeft: "ز", .swipeDownLeft: "ع"],
                GridSlot.bottomLeft: [.swipeUp: "ّ", .swipeUpLeft: "ٓ", .swipeUpRight: "ؤ"],
                GridSlot.bottomCenter: [
                    .swipeUp: "ث", .swipeUpLeft: "ظ", .swipeUpRight: "غ",
                    .swipeLeft: "ء", .swipeRight: "أ", .swipeDownRight: "ئ",
                ],
                GridSlot.bottomRight: [
                    .swipeUp: "ً", .swipeUpLeft: "ۋ", .swipeUpRight: "ْ",
                    .swipeLeft: "ذ",
                ],
            ]),
            returnOverrides: ScriptPunctuation.arabicScriptReturns(adding: [
                GridSlot.topCenter: [.swipeUp: "ٌ", .swipeUpLeft: "ٍ", .swipeUpRight: "ً"],
                GridSlot.midLeft: [.swipeDown: "ئ"],
                GridSlot.bottomCenter: [.swipeRight: "إ"],
                GridSlot.bottomRight: [.swipeUpLeft: "گ"],
            ]),
            supportsCapitalization: false,
            numericBackToAlphaLabel: "ابت",
            numericDigits: NumericLayouts.arabicIndicDigits
        )
    }

    static let persian = LanguageDescriptor(
        id: "fa_IR",
        title: "فارسی (Persian)",
        localeIdentifier: "fa_IR"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["ه", "ب", "م", ""],
                ["ی", "ا", "ر", ""],
                ["و", "ن", "د", ""],
            ],
            directionalOverrides: ScriptPunctuation.arabicScript(adding: [
                GridSlot.topLeft: [.swipeRight: "ـ", .swipeDown: "ۀ", .swipeDownRight: "ق"],
                GridSlot.topCenter: [
                    .swipeUp: "ُ", .swipeUpLeft: "ِ", .swipeUpRight: "َ",
                    .swipeDown: "خ", .swipeDownLeft: "ض", .swipeDownRight: "پ",
                ],
                GridSlot.topRight: [.swipeDownLeft: "چ"],
                GridSlot.midLeft: [.swipeUpRight: "ص", .swipeRight: "ش", .swipeDownRight: "ط"],
                GridSlot.center: [
                    .swipeUp: "ح", .swipeUpLeft: "ف", .swipeUpRight: "ج",
                    .swipeLeft: "س", .swipeRight: "آ", .swipeDown: "ت",
                    .swipeDownLeft: "ل", .swipeDownRight: "ک",
                ],
                GridSlot.midRight: [.swipeUpLeft: "ژ", .swipeLeft: "ز", .swipeDownLeft: "ع"],
                GridSlot.bottomLeft: [.swipeUp: "ّ", .swipeUpLeft: "ٓ", .swipeUpRight: "ؤ"],
                GridSlot.bottomCenter: [
                    .swipeUp: "ث", .swipeUpLeft: "ظ", .swipeUpRight: "غ",
                    .swipeLeft: "ء", .swipeRight: "أ", .swipeDownRight: "ئ",
                ],
                GridSlot.bottomRight: [
                    .swipeUp: "ً", .swipeUpLeft: "گ", .swipeUpRight: "ْ",
                    .swipeLeft: "ذ",
                ],
            ]),
            returnOverrides: ScriptPunctuation.arabicScriptReturns(adding: [
                // The tatweel key's return swipe types ZWNJ (U+200C) — the
                // half-space standard Persian orthography puts inside a word to
                // keep a prefix or suffix from joining the stem. Written as an
                // escape so the source carries no invisible character.
                GridSlot.topLeft: [.swipeRight: "\u{200C}", .swipeDown: "ة", .swipeDownRight: "ف"],
                GridSlot.topCenter: [
                    .swipeUp: "ٌ", .swipeUpLeft: "ٍ", .swipeUpRight: "ً",
                    .swipeDown: "ح", .swipeDownLeft: "ص", .swipeDownRight: "ب",
                ],
                GridSlot.topRight: [.swipeDownLeft: "ج"],
                GridSlot.midLeft: [.swipeUpRight: "ض", .swipeRight: "س", .swipeDownRight: "ظ"],
                GridSlot.center: [
                    .swipeUp: "خ", .swipeUpLeft: "ق", .swipeUpRight: "چ",
                    .swipeLeft: "ش", .swipeRight: "ا", .swipeDown: "ث",
                    .swipeDownRight: "گ",
                ],
                GridSlot.midRight: [.swipeLeft: "ر", .swipeDownLeft: "غ"],
                GridSlot.bottomCenter: [
                    .swipeUp: "ت", .swipeUpLeft: "ط", .swipeUpRight: "ع",
                    .swipeRight: "إ",
                ],
                GridSlot.bottomRight: [.swipeUpLeft: "ک", .swipeLeft: "د"],
            ]),
            supportsCapitalization: false,
            numericBackToAlphaLabel: "ابپ",
            numericDigits: NumericLayouts.persianDigits
        )
    }

    static let urdu = LanguageDescriptor(
        id: "ur",
        title: "اردو (Urdu)",
        localeIdentifier: "ur"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["ه", "ب", "م", ""],
                ["ی", "ا", "ر", ""],
                ["و", "ن", "د", ""],
            ],
            directionalOverrides: ScriptPunctuation.arabicScript(adding: [
                GridSlot.topLeft: [
                    .swipeUp: "ٹ", .swipeRight: "ـ", .swipeDown: "ۀ",
                    .swipeDownRight: "ق",
                ],
                GridSlot.topCenter: [
                    .swipeUp: "ُ", .swipeUpLeft: "ِ", .swipeUpRight: "َ",
                    .swipeDown: "خ", .swipeDownLeft: "ض", .swipeDownRight: "پ",
                ],
                GridSlot.topRight: [.swipeDownLeft: "چ"],
                GridSlot.midLeft: [
                    .swipeUp: "ۓ", .swipeUpRight: "ص", .swipeRight: "ح",
                    .swipeDown: "ے", .swipeDownRight: "ط",
                ],
                GridSlot.center: [
                    .swipeUp: "ج", .swipeUpLeft: "ف", .swipeUpRight: "ش",
                    .swipeLeft: "س", .swipeRight: "آ", .swipeDown: "ت",
                    .swipeDownLeft: "ل", .swipeDownRight: "ک",
                ],
                GridSlot.midRight: [
                    .swipeUp: "ڑ", .swipeUpLeft: "ژ", .swipeLeft: "ز",
                    .swipeDown: "ڈ", .swipeDownLeft: "ع",
                ],
                GridSlot.bottomLeft: [.swipeUp: "ّ", .swipeUpLeft: "ٓ", .swipeUpRight: "ؤ"],
                GridSlot.bottomCenter: [
                    .swipeUp: "ث", .swipeUpLeft: "ظ", .swipeUpRight: "غ",
                    .swipeLeft: "ء", .swipeRight: "ں", .swipeDownRight: "ئ",
                ],
                GridSlot.bottomRight: [
                    .swipeUp: "ً", .swipeUpLeft: "گ", .swipeUpRight: "ْ",
                    .swipeLeft: "ذ",
                ],
            ]),
            returnOverrides: ScriptPunctuation.arabicScriptReturns(adding: [
                // See the Persian layout: the tatweel return types ZWNJ (U+200C).
                GridSlot.topLeft: [.swipeRight: "\u{200C}", .swipeDown: "ة"],
                GridSlot.topCenter: [.swipeUp: "ٌ", .swipeUpLeft: "ٍ", .swipeUpRight: "ً"],
            ]),
            supportsCapitalization: false,
            numericBackToAlphaLabel: "ابپ",
            numericDigits: NumericLayouts.persianDigits
        )
    }

    // MARK: Thai

    static let thai = LanguageDescriptor(
        id: "th_TH",
        title: "ไทย (Thai)",
        localeIdentifier: "th_TH"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["า", "น", "ั", ""],
                ["ก", "อ", "ร", ""],
                ["ม", "เ", "ง", ""],
            ],
                        directionalOverrides: [
                GridSlot.r0c0: [
                    .swipeUp: "ุ",
                    .swipeDown: "ู",
                ],
                GridSlot.r0c1: [
                    .swipeUp: "ณ",
                    .swipeDown: "ล",
                ],
                GridSlot.r0c2: [.swipeDown: "ะ"],
                GridSlot.r1c0: [
                    .swipeUp: "ื",
                    .swipeDown: "ใ",
                ],
                GridSlot.r1c1: [
                    .swipeUp: "้",
                    .swipeDown: "ด",
                ],
                GridSlot.r2c0: [
                    .swipeUp: "ำ",
                    .swipeDown: "๋",
                ],
                GridSlot.r2c1: [.swipeUp: "ว"],
                GridSlot.r2c2: [.swipeUp: "ฉ"],
                GridSlot.r0c3: [.swipeUp: "็"],
                GridSlot.r1c3: [.swipeUp: "ฤ"],
                GridSlot.r2c3: [.swipeUp: "ญ"],
            ],
            returnOverrides: [
                GridSlot.r0c0: [
                    .swipeUp: "ู", .swipeUpRight: "ี", .swipeLeft: "ฺ",
                    .swipeDown: "ุ", .swipeDownLeft: "พ", .swipeDownRight: "ิ",
                ],
                GridSlot.r0c1: [
                    .swipeUp: "โ", .swipeUpLeft: "ใ", .swipeUpRight: "ไ",
                    .swipeDown: "ฦ", .swipeDownRight: "ญ",
                ],
                GridSlot.r0c2: [
                    .swipeUpLeft: "ฆ", .swipeRight: "ฃ", .swipeDown: "ข",
                    .swipeDownLeft: "ฯ", .swipeDownRight: "ถ",
                ],
                GridSlot.r1c0: [
                    .swipeUp: "ึ", .swipeUpLeft: "ื", .swipeUpRight: "จ",
                    .swipeRight: "ข", .swipeDown: "ๅ", .swipeDownLeft: "ฦ",
                    .swipeDownRight: "ฤ",
                ],
                GridSlot.r1c1: [
                    .swipeUp: "๋", .swipeUpLeft: "๊", .swipeUpRight: "ผ",
                    .swipeLeft: "ฉ", .swipeRight: "ษ", .swipeDown: "ฎ",
                    .swipeDownLeft: "ฮ", .swipeDownRight: "ช",
                ],
                // ฿ rides the ท key's return swipe, matching the reference.
                GridSlot.r1c2: [
                    .swipeUpLeft: "ฝ", .swipeUpRight: "ภ", .swipeLeft: "฿",
                    .swipeDownLeft: "ฟ", .swipeDownRight: "ณ",
                ],
                GridSlot.r2c0: [
                    .swipeUp: "์", .swipeUpLeft: "แ", .swipeUpRight: "๎",
                    .swipeLeft: "็",
                ],
                GridSlot.r2c1: [.swipeUp: "ๆ", .swipeRight: "ํ"],
                GridSlot.r2c2: [.swipeUp: "ฌ", .swipeRight: "ซ", .swipeDownLeft: "ำ"],
            ],
            // The reference's center returns: circling a key types a second
            // consonant. Four of them (ฬ ฒ ฑ ฏ) have no other position in the
            // layout, so without this they cannot be typed at all.
            circularOverrides: [
                GridSlot.r0c0: "ฬ", GridSlot.r0c1: "ณ", GridSlot.r0c2: "ฎ",
                GridSlot.r1c0: "ธ", GridSlot.r1c1: "ฮ", GridSlot.r1c2: "ฐ",
                GridSlot.r2c0: "ฒ", GridSlot.r2c1: "ฑ", GridSlot.r2c2: "ฏ",
            ],
            supportsCapitalization: false,
            numericBackToAlphaLabel: "กขค",
            numericDigits: NumericLayouts.thaiDigits
        )
    }

    // MARK: Hindi

    static let hindi = LanguageDescriptor(
        id: "hi_IN",
        title: "हिन्दी (Hindi)",
        localeIdentifier: "hi_IN"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["म", "न", "ल", ""],
                ["ह", "क", "र", ""],
                ["त", "प", "स", ""],
            ],
                        directionalOverrides: [
                GridSlot.r0c0: [
                    .swipeUp: "ः",
                    .swipeDown: "ओ",
                ],
                GridSlot.r0c1: [
                    .swipeUp: "आ",
                    .swipeDown: "व",
                ],
                GridSlot.r1c0: [
                    .swipeUp: "ऑ",
                    .swipeDown: "झ",
                ],
                GridSlot.r1c1: [
                    .swipeUp: "ा",
                    .swipeDown: "्",
                ],
                GridSlot.r1c2: [
                    .swipeUp: "ट",
                    .swipeDown: "।",
                ],
                GridSlot.r2c0: [.swipeUp: "ऐ"],
                GridSlot.r2c1: [.swipeUp: "ए"],
                GridSlot.r2c2: [.swipeUp: "च"],
                GridSlot.r0c3: [.swipeUp: "अ"],
                GridSlot.r1c3: [.swipeUp: "ढ"],
                GridSlot.r2c3: [.swipeUp: "ॉ"],
            ],
            supportsCapitalization: false,
            numericBackToAlphaLabel: "कखग",
            numericDigits: NumericLayouts.devanagariDigits,
            combineRuleSet: hindiCombineRules
        )
    }

    /// Devanagari vowel lengthening (short vowel typed twice → long).
    /// From MessagEase `hindiCombine`; `trigger` is the second-typed vowel.
    private static let hindiCombineRules = ComposeRuleSet(rules: [
        "इ": ["इ": "ई"],
        "उ": ["उ": "ऊ"],
        "ऋ": ["ऋ": "ॠ"],
        "ऌ": ["ऌ": "ॡ"],
        "ऍ": ["ऍ": "ऎ"],
    ])

    // MARK: Japanese kana

    static let hiragana = LanguageDescriptor(
        id: "ja_JP",
        title: "日本語 かな (Hiragana)",
        localeIdentifier: "ja_JP"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: hiraganaCenterCharacters,
            directionalOverrides: hiraganaDirectionalOverrides,
            returnOverrides: hiraganaReturnOverrides,
            circularOverrides: hiraganaCircularOverrides,
            supportsCapitalization: false,
            numericBackToAlphaLabel: "かな",
            combineRuleSet: hiraganaCombineRules
        )
    }

    private static let hiraganaCenterCharacters: [[String]] = [
        ["く", "つ", "い", ""],
        ["ふ", "る", "ら", ""],
        ["と", "ん", "す", ""],
    ]

    private static let hiraganaDirectionalOverrides: [String: [GestureType: String]] = [
        GridSlot.topLeft: [.swipeRight: "ー", .swipeDown: "や", .swipeDownRight: "さ"],
        GridSlot.topCenter: [
            .swipeUp: "そ", .swipeUpLeft: "め", .swipeUpRight: "も",
            .swipeDown: "ま",
        ],
        GridSlot.topRight: [.swipeDownLeft: "ひ"],
        GridSlot.midLeft: [
            .swipeLeft: "せ", .swipeRight: "き", .swipeDown: "わ",
            .swipeDownLeft: "へ", .swipeDownRight: "に",
        ],
        GridSlot.center: [
            .swipeUp: "あ", .swipeUpLeft: "か", .swipeUpRight: "し",
            .swipeLeft: "は", .swipeRight: "り", .swipeDown: "れ",
            .swipeDownLeft: "た", .swipeDownRight: "ほ",
        ],
        GridSlot.midRight: [
            .swipeUpLeft: "ゆ", .swipeLeft: "ろ", .swipeRight: "み",
            .swipeDownRight: "ち",
        ],
        GridSlot.bottomLeft: [
            .swipeUp: "の", .swipeUpLeft: "ゝ", .swipeUpRight: "む",
            .swipeLeft: "を", .swipeRight: "う", .swipeDown: "な",
        ],
        // 、 and 。 replace the shared Latin comma and full stop, which stay one
        // return swipe away (see `hiraganaReturnOverrides`) and keep their
        // positions on the numeric layer. `AutoCapitalization` counts 。 as a
        // sentence ender.
        GridSlot.bottomCenter: [
            .swipeUp: "て", .swipeUpLeft: "゛", .swipeLeft: "ね",
            .swipeRight: "け", .swipeDown: "。", .swipeDownLeft: "、",
        ],
        GridSlot.bottomRight: [
            .swipeUp: "え", .swipeUpLeft: "こ", .swipeLeft: "よ",
            .swipeRight: "ぬ", .swipeDownLeft: "お",
        ],
    ]

    /// Small kana are the reference's *return* outputs on their full-size
    /// counterparts (や → ゃ, あ → ぁ), and the voiced iteration mark ゞ is the
    /// return of ゝ. A caseless script gets no auto-generated return, so
    /// without these a return swipe just repeats the plain kana and the small
    /// and voiced forms are reachable only through the accent-cycle key.
    /// Consonant voicing stays on the ゛ key (`hiraganaCombineRules`).
    /// `bottomCenter` keeps the Latin comma and full stop that 、 and 。 displace.
    private static let hiraganaReturnOverrides: [String: [GestureType: String]] = [
        GridSlot.topLeft: [.swipeDown: "ゃ"],
        GridSlot.center: [.swipeUp: "ぁ"],
        GridSlot.midRight: [.swipeUpLeft: "ゅ"],
        GridSlot.bottomLeft: [.swipeUpLeft: "ゞ", .swipeRight: "ぅ"],
        GridSlot.bottomCenter: [.swipeDown: ".", .swipeDownLeft: ","],
        GridSlot.bottomRight: [.swipeUp: "ぇ", .swipeLeft: "ょ", .swipeDownLeft: "ぉ"],
    ]

    /// Circle gesture, the reference's center return: the voiced form of the
    /// key's own kana, or the small form for い and つ. ぃ has no other position
    /// in the layout.
    private static let hiraganaCircularOverrides: [String: String] = [
        GridSlot.topLeft: "ぐ", GridSlot.topCenter: "っ", GridSlot.topRight: "ぃ",
        GridSlot.midLeft: "ぶ", GridSlot.bottomLeft: "ど", GridSlot.bottomRight: "ず",
    ]

    /// Dakuten voicing (kana + ゛ → voiced kana), from MessagEase hiraganaCombine.
    /// A second ゛ cascades the ha-row voiced kana to their handakuten form
    /// (ば→ぱ …) and the voiced づ to the sokuon っ, so the single ゛ key reaches
    /// ぱぴぷぺぽ and っ; the iteration mark voices like a consonant (ゝ→ゞ)
    /// (all matching the global ゛ table).
    private static let hiraganaCombineRules = ComposeRuleSet(rules: [
        "゛": [
            "か": "が", "き": "ぎ", "く": "ぐ", "け": "げ", "こ": "ご", "さ": "ざ",
            "し": "じ", "す": "ず", "せ": "ぜ", "そ": "ぞ", "た": "だ", "ち": "ぢ",
            "つ": "づ", "て": "で", "と": "ど", "は": "ば", "ひ": "び", "ふ": "ぶ",
            "へ": "べ", "ほ": "ぼ", "う": "ゔ", "ゝ": "ゞ",
            "ば": "ぱ", "び": "ぴ", "ぶ": "ぷ", "べ": "ぺ", "ぼ": "ぽ", "づ": "っ",
        ],
    ])

    static let katakana = LanguageDescriptor(
        id: "ja_JP_katakana",
        title: "日本語 カナ (Katakana)",
        // The registry key (id) stays unique, but the locale drives uppercasing
        // and system APIs, so it must be a valid BCP-47 tag — plain "ja_JP".
        localeIdentifier: "ja_JP"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: katakanaCenterCharacters,
            directionalOverrides: katakanaDirectionalOverrides,
            returnOverrides: katakanaReturnOverrides,
            circularOverrides: katakanaCircularOverrides,
            supportsCapitalization: false,
            numericBackToAlphaLabel: "カナ",
            combineRuleSet: katakanaCombineRules
        )
    }

    /// Katakana shares hiragana's key arrangement glyph-for-glyph, so its
    /// center characters and swipe overrides are *derived* from the hiragana
    /// tables via ICU `.hiraganaToKatakana` rather than hand-maintained. This
    /// keeps the two kana layouts from drifting apart. A characterization test
    /// (`KatakanaDerivationTests`) pins the derived tables to the previously
    /// hand-authored values, proving zero behavior change.
    ///
    /// Four genuine katakana-only deltas are layered on top: the ・ separator on
    /// `bottomCenter.swipeDownRight` (below), the ":" it displaces on that
    /// gesture's return swipe, the small ヮ on `midLeft.swipeDown`, and the
    /// wa-row voiced combine entries in `katakanaCombineRules` (which the
    /// transform cannot supply).
    static let katakanaCenterCharacters: [[String]] =
        hiraganaCenterCharacters.map { $0.map(katakanize) }

    static let katakanaDirectionalOverrides: [String: [GestureType: String]] = {
        var derived = hiraganaDirectionalOverrides.mapValues { overrides in
            overrides.mapValues(katakanize)
        }
        // Katakana-only delta: the ・ (nakaguro) separator has no hiragana
        // counterpart, so it is added rather than derived.
        derived[GridSlot.bottomCenter, default: [:]][.swipeDownRight] = "・"
        return derived
    }()

    static let katakanaReturnOverrides: [String: [GestureType: String]] = {
        var derived = hiraganaReturnOverrides.mapValues { returns in
            returns.mapValues(katakanize)
        }
        // Katakana-only deltas, both from the reference: ヮ has no hiragana
        // counterpart on this key, and the ・ separator keeps the ":" it displaces.
        derived[GridSlot.midLeft, default: [:]][.swipeDown] = "ヮ"
        derived[GridSlot.bottomCenter, default: [:]][.swipeDownRight] = ":"
        return derived
    }()

    static let katakanaCircularOverrides: [String: String] =
        hiraganaCircularOverrides.mapValues(katakanize)

    /// Maps a single hiragana glyph to its katakana counterpart. The shared
    /// sound/iteration marks (゛ ゜ → unchanged, ゝ → ヽ) and the prolonged-sound
    /// mark ー are handled by the ICU transform; a glyph the transform cannot
    /// map is returned unchanged.
    private static func katakanize(_ glyph: String) -> String {
        glyph.applyingTransform(.hiraganaToKatakana, reverse: false) ?? glyph
    }

    /// Dakuten voicing (kana + ゛ → voiced kana), from MessagEase katakanaCombine.
    /// A second ゛ cascades the ha-row voiced kana to their handakuten form
    /// (バ→パ …) and the voiced ヅ to the sokuon ッ; the iteration mark voices
    /// like a consonant (ヽ→ヾ), matching the global ゛ table.
    private static let katakanaCombineRules = ComposeRuleSet(rules: [
        "゛": [
            "カ": "ガ", "キ": "ギ", "ク": "グ", "ケ": "ゲ", "コ": "ゴ", "サ": "ザ",
            "シ": "ジ", "ス": "ズ", "セ": "ゼ", "ソ": "ゾ", "タ": "ダ", "チ": "ヂ",
            "ツ": "ヅ", "テ": "デ", "ト": "ド", "ハ": "バ", "ヒ": "ビ", "フ": "ブ",
            "ヘ": "ベ", "ホ": "ボ", "ウ": "ヴ", "ワ": "ヷ", "ヰ": "ヸ", "ヱ": "ヹ",
            "ヲ": "ヺ", "ヽ": "ヾ",
            "バ": "パ", "ビ": "ピ", "ブ": "プ", "ベ": "ペ", "ボ": "ポ", "ヅ": "ッ",
        ],
    ])

    // MARK: Korean

    static let korean = LanguageDescriptor(
        id: "ko_KR",
        title: "한국어 (Korean)",
        localeIdentifier: "ko_KR"
    ) { meta in
        GridKeyboardFactory.layout(
            id: meta.id,
            title: meta.title,
            localeIdentifier: meta.localeIdentifier,
            centerCharacters: [
                ["ㄷ", "ㄹ", "ㅈ", ""],
                ["ㄱ", "ㅇ", "ㄴ", ""],
                ["ㅁ", "ㅅ", "ㅎ", ""],
            ],
                        directionalOverrides: [
                GridSlot.r0c1: [.swipeDown: "ㅛ"],
                GridSlot.r1c1: [
                    .swipeUp: "ㅗ",
                    .swipeDown: "ㅜ",
                ],
                GridSlot.r2c1: [.swipeUp: "ㅠ"],
                GridSlot.r0c3: [.swipeUp: "ㅊ"],
                GridSlot.r1c3: [.swipeUp: "ㅓ"],
                GridSlot.r2c3: [.swipeUp: "ㅂ"],
            ],
            returnOverrides: [
                // Complex vowels are reached by a return swipe on the plain
                // vowel (ㅐ→ㅒ, ㅔ→ㅖ), matching the MessagEase Korean layout.
                // Tense consonants (ㄲㄸㅃㅆㅉ) are produced instead by repeating
                // the base consonant, handled in HangulComposer.
                GridSlot.r1c1: [.swipeDownLeft: "ㅒ", .swipeUpLeft: "ㅖ"],
            ],
            supportsCapitalization: false,
            numericBackToAlphaLabel: "가나다",
            inputMethod: .hangul
        )
    }
}

// MARK: - Registry

extension LanguageDefinitions {
    /// All available language descriptors, sorted alphabetically by title.
    ///
    /// Holds metadata only; definitions are built lazily via
    /// `LanguageDescriptor.makeDefinition()` (see `KeyboardRegistry`).
    static let all: [LanguageDescriptor] = [
        spanishCatalan,
        arabic,
        croatian,
        english,
        estonianFinnish,
        finnish,
        french,
        german,
        greek,
        hebrew,
        hindi,
        hiragana,
        italian,
        katakana,
        korean,
        persian,
        polish,
        portuguese,
        russian,
        spanish,
        swedish,
        tagalog,
        thai,
        ukrainian,
        urdu,
        vietnamese,
    ].sorted { $0.title < $1.title }
}
