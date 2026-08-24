# Wurstfinger Duo Layout Specification & Verification Checklist

This document specifies the custom keyboard layout implemented for **Wurstfinger Duo**, a **4-row × 4-column letter grid (plus trailing utility column)** restricted to **Vertical-Only Swipes (Tap, Swipe Up, Swipe Down)** for letter keys, with a dedicated 4×5 number/symbol layer.

---

## 1. Architectural & Grid Specifications

### 1.1 Grid Dimensions & Slots (`GridSlot.swift`, `StandardArrangements.swift`, `KeyboardConstants.swift`)
- **Rows:** 4 grid rows (`r0`, `r1`, `r2`, `r3`) + 1 bottom arrangement row.
- **Columns:** 5 columns total per row (`0`, `1`, `2`, `3` for letter/utility keys, and `4` fixed as the trailing Utility Column).
- **Total Rows Metric (`KeyboardConstants.KeyDimensions.totalRows`):** `5` (to allocate proper height scaling).
- **Arrangement Layouts (`StandardArrangements.swift`):**
  - **Portrait / Landscape / Numeric:** Configured with `columns: 5`.
  - **Spacebar:** Spans columns 1–3 on row 3 (`widthMultiplier: 3`).
  - **r3c0:** Occupies column 0 on row 3.
  - **Trailing Utility Column (Column 4):**
    - Row 0: Clipboard (`UtilitySlot.clipboard`)
    - Row 1: Autocomplete (`UtilitySlot.autocomplete`)
    - Row 2: Delete (`UtilitySlot.delete`)
    - Row 3: Return (`UtilitySlot.return`)

---

## 2. Gesture Restriction & Swipe Mode (`GridKeyboardFactory.swift`)
- **Swipe Mode:** All letter keys are configured with `swipeMode: .twoWayVertical`.
- **Allowed Gestures per Letter Key:**
  1. **Tap:** Center character insertion.
  2. **Swipe Up:** Custom assigned upper symbol/letter.
  3. **Swipe Down:** Custom assigned lower symbol/letter.
- **Disabled Gestures:** All horizontal (`.swipeLeft`, `.swipeRight`) and diagonal (`.swipeUpLeft`, etc.) swipes are disabled and unbound on letter keys.

---

## 3. Key Mapping Specification

### 3.1 Letter Grid Slots (Rows 0–2, Columns 0–3)

| Slot | Tap (Center) | Swipe Up (▲) | Swipe Down (▼) |
| :--- | :---: | :---: | :---: |
| **r0c0** | `l` | `-` | `w` |
| **r0c1** | `d` | `/` | `b` |
| **r0c2** | `i` | `!` | `x` |
| **r0c3** | `o` | `?` | `g` |
| **r1c0** | `n` | `v` | `f` |
| **r1c1** | `t` | `q` | `k` |
| **r1c2** | `h` | `:` | `u` |
| **r1c3** | `c` | `y` | `p` |
| **r2c0** | `s` | Shift Toggle (`⇧`) | `z` |
| **r2c1** | `r` | `j` | `m` |
| **r2c2** | `a` | `'` | `,` |
| **r2c3** | `e` | `"` | `.` |

---

### 3.2 Trailing Utility Column (Column 4) & Bottom Row

- **Column 4, Row 0 (`clipboard`):**
  - Tap: Cut (`.cut`)
  - Swipe Up: Copy (`.copy`)
  - Swipe Down: Paste (`.paste`)
- **Column 4, Row 1 (`autocomplete`):**
  - Tap: Inserts `"auto"` (`.autocomplete`)
- **Column 4, Row 2 (`delete`):**
  - Tap / Swipe Horizontal / Slide: Standard progressive & continuous slide delete (`.deleteBackward`).
- **Column 4, Row 3 (`return`):**
  - Tap: Newline (`.newline`)
  - Swipe Down: Hide Keyboard (`.dismissKeyboard`)

- **Bottom Row Left (`r3c0`):**
  - Tap: Switch to Numeric Mode (`.switchMode(ModeNames.numeric)`, labelled `"123"`)
  - Swipe Up: Emoji Layer (`.switchMode(ModeNames.emoji)`)
  - Swipe Down: Next Input Method / Globe (`.advanceToNextInputMode`)

- **Spacebar (`UtilitySlot.space`, spans columns 1–3):**
  - Tap: Space (`.space`)
  - Slide: Move cursor (`.moveCursor`)
  - Long Press: Native zero (`0`)

---

### 3.3 Numeric Layer (4 Rows × 5 Columns)

| Slot | Tap | Swipe Up (▲) | Swipe Down (▼) |
| :--- | :---: | :---: | :---: |
| **n0c0** | `-` | `` ` `` | `_` |
| **n0c1** | `1` | `<` | `!` |
| **n0c2** | `2` | `>` | `@` |
| **n0c3** | `3` | `|` | `#` |
| **n1c0** | `=` | `[` | `+` |
| **n1c1** | `4` | `]` | `$` |
| **n1c2** | `5` | `(` | `%` |
| **n1c3** | `6` | `)` | `^` |
| **n2c0** | `.` | `⇧` (Shift) | `•` (bullet) |
| **n2c1** | `7` | `{` | `&` |
| **n2c2** | `8` | `}` | `*` |
| **n2c3** | `9` | `;` | `/` |
| **n3c0** | `ABC` (→ letters) | Emoji | Globe (next input) |
| **n3c1** | `0` | `:` | `\` |
| **n3c2–3** | Spacebar (spans 2 cols) | — | — |
| **n3c4** | Return (↵) | — | Hide Keyboard |
| **Utility col 4** | Clipboard / Autocomplete / Delete / Return | _same gestures as main layer_ | |

For non-Latin scripts, the digit glyphs (0–9) are replaced with the language's digit set; all symbols remain fixed.

---

## 4. Verification Checklist for Auditor Agent

A separate auditor agent should independently verify the following items against the codebase:

1. **Grid Constants:** Verify `KeyboardConstants.KeyDimensions.totalRows` is set to `5`.
2. **Arrangements:** Verify `StandardArrangements.swift` defines portrait and landscape arrangements with `columns: 5` and includes rows with `r0c0` through `r3c3` plus the utility column keys (`clipboard`, `autocomplete`, `delete`, `return`).
3. **Swipe Mode Enforcements:** Verify `GridKeyboardFactory.swift` instantiates letter keys with `swipeMode: .twoWayVertical`.
4. **Action Pipeline & Autocomplete:** Verify `KeyAction.swift` includes `.autocomplete`, `TextInputMiddleware.swift` handles it by inserting `"auto"`, and `KeyCategory.swift` classifies it under `.utility`.
5. **Language Definition Overrides:** Verify `LanguageDefinitions.swift` (English and others) correctly populates `centerCharacters` as a 3×4 matrix and maps directional overrides strictly to `.swipeUp` and `.swipeDown` for `r0c0` through `r2c3`.
6. **Numeric Layer Integration:** Verify `NumericLayouts.swift` builds a 4×5 grid with `n0c0`–`n3c3` slots, digit placeholders use the language digit set, and the back-to-alpha key at `n3c0` carries the script-appropriate label.
7. **Shift Behavior:** Shift is on `r2c0.swipeUp`. A full mode toggle (main → shifted → capsLock) with auto-transition back to main after typing a letter. Caps Lock's swipeUp cycles back to main (no dead-end mode).

---

## 5. Implementation Reference

### 5.1 Key Files

| File | Purpose |
|------|---------|
| `Definition/Layout/GridSlot.swift` | Coordinate-based slot IDs (`r0c0`–`r3c3`), legacy names for numeric compatibility |
| `Definition/Layout/UtilitySlot.swift` | `clipboard` and `autocomplete` identifiers |
| `Definition/Layout/StandardArrangements.swift` | Portrait/landscape/numeric arrangements for 5-column, 4-row grid |
| `Settings/KeyboardConstants.swift` | `totalRows` = 5 |
| `Definition/Language/GridKeyboardFactory.swift` | Letter key `swipeMode`: `.twoWayVertical`, precondition for 3×4 matrix |
| `Definition/Language/CommonKeys.swift` | `clipboard`, `autocomplete`, `r3c0` key configs; `defaultSlotBindings` with vertical-only bindings; `return` with `.dismissKeyboard` on swipeDown |
| `Definition/Language/NumericLayouts.swift` | 4×5 numeric layer: symbol column + digit columns + shared utility column |
| `Definition/Model/KeyAction.swift` | `.autocomplete` case |
| `Definition/Model/KeyCategory.swift` | `.autocomplete` → `.utility` mapping |
| `Runtime/Pipeline/TextInputMiddleware.swift` | `.autocomplete` → `"auto"` insertion |
| `Runtime/Pipeline/AutoCapitalizationMiddleware.swift` | `.autocomplete` in `affectsCapitalization` |
| `Definition/Language/LanguageDefinitions.swift` | English main layer: `r0c2` ↔ `r1c2` and `r0c3` ↔ `r1c3` swapped per Wurstfinger Duo spec; all overrides converted to vertical-only new slots |

### 5.2 Files Unchanged

| File | Reason |
|------|--------|
| `Runtime/View/KeyboardGridView.swift` | Already generic — renders any `GridArrangement` |
| `Runtime/View/KeyboardGridLayout.swift` | Already generic — positions cells by span |
| `Definition/Layout/GridLayoutSolver.swift` | Already generic — solves any arrangement |
| `KeyboardViewController.swift` | No layout-specific logic |
| `KeyboardViewModel.swift` | No layout-specific logic |

---

## 6. Language Migration Notes

### 6.1 Center Character Strategy

Every language uses a 3×4 center matrix. The 4th column is **empty** (`""`) for most non-English languages. The slots `r0c3`, `r1c3`, `r2c3` function as **swipe-only keys** producing extra letters displaced from horizontal/diagonal swipes.

### 6.2 English Main-Layer Layout

The English layout uses all 12 grid slots with the following 4-swap arrangement (relative to the earlier iteration):

- **r0c2** = `i` (was `h`), swipeUp `-`, swipeDown `x`
- **r0c3** = `o` (was `c`), swipeUp `?`, swipeDown `g`
- **r1c2** = `h` (was `i`), swipeUp `:`, swipeDown `u`
- **r1c3** = `c` (was `o`), swipeUp `y`, swipeDown `p`

This swap places higher-frequency letters on row 0 for faster access.

---

## 7. Testing & Build

### 7.1 Build Verification
- The project **builds successfully** against `iPhone 17` simulator target with `xcodebuild build`.
- All `WurstfingerTests` pass (verified via `xcodebuild test`).
- No compiler warnings related to the grid changes.

### 7.2 Runtime Behaviours to Verify (Manual)

1. **Grid rendering:** Open the keyboard in-simulator. Verify 5 columns, 4 letter rows + space/return row render without overlaps or gaps.
2. **Vertical swipe restriction:** Tap a letter key → center character. Swipe up → upper character. Swipe down → lower character. Swipe left/right → should do nothing (no binding).
3. **Shift behaviour:** Swipe up on `r2c0` (S key) → shifted mode. Tap any letter → uppercase, auto-transition back to lowercase. Tap shift again → caps lock. Swipe up on shift in caps lock → lowercase.
4. **Clipboard utility:** Tap clipboard → cut. Swipe up → copy. Swipe down → paste.
5. **Autocomplete:** Tap autocomplete → types `"auto"`.
6. **Return key:** Tap → newline. Swipe down → keyboard dismisses.
7. **r3c0 (bottom-left):** Tap → numeric layer. Swipe up → emoji (inert). Swipe down → next input method.
8. **Spacebar:** Tap → space. Drag → cursor moves. Long press → zero digit.
9. **Numeric layer:** Verify 4×5 grid; column 0 = symbols (~ = + .), columns 1–3 = digits, column 4 = utility. Back-to-alpha (`ABC`) on n3c0, zero on n3c1, space spans n3c2–3.
10. **Delete key:** Tap → delete one character. Swipe left/right → continuous delete.
11. **Landscape orientation:** Rotate device → same grid, utility column on leading edge.
12. **Punctuation:** r2c2 swipeUp → `'`, swipeDown → `,`. r2c3 swipeUp → `"`, swipeDown → `.`. r0c2 swipeUp → `-`. r0c3 swipeUp → `?`.
13. **Numeric layer symbols:** Verify ~ * /, = + -, . ⇧ ⇥, `_ )` on their respective slots.