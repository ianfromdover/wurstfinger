# Wurstfinger Custom Layout Specification & Verification Checklist

This document specifies the custom keyboard layout implemented for **Wurstfinger**, transitioning the keyboard from a 3×3 letter grid with 8-way directional swipes to a **4-row × 4-column letter grid (plus trailing utility column)** restricted to **Vertical-Only Swipes (Tap, Swipe Up, Swipe Down)**, along with custom utility row assignments and autocomplete functionality.

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
| **r0c0** | `L` | `W` | `V` |
| **r0c1** | `D` | `Q` | `B` |
| **r0c2** | `H` | `:` | `U` |
| **r0c3** | `C` | `Y` | `P` |
| **r1c0** | `N` | `!` | `F` |
| **r1c1** | `T` | `/` | `K` |
| **r1c2** | `I` | `-` | `X` |
| **r1c3** | `O` | `?` | `G` |
| **r2c0** | `S` | Shift Toggle (`⇧`) | `Z` |
| **r2c1** | `R` | `J` | `M` |
| **r2c2** | `A` | `'` | `,` |
| **r2c3** | `E` | `"` | `.` |

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

## 4. Verification Checklist for Auditor Agent

A separate auditor agent should independently verify the following items against the codebase:

1. **Grid Constants:** Verify `KeyboardConstants.KeyDimensions.totalRows` is set to `5`.
2. **Arrangements:** Verify `StandardArrangements.swift` defines portrait and landscape arrangements with `columns: 5` and includes rows with `r0c0` through `r3c3` plus the utility column keys (`clipboard`, `autocomplete`, `delete`, `return`).
3. **Swipe Mode Enforcements:** Verify `GridKeyboardFactory.swift` instantiates letter keys with `swipeMode: .twoWayVertical`.
4. **Action Pipeline & Autocomplete:** Verify `KeyAction.swift` includes `.autocomplete`, `TextInputMiddleware.swift` handles it by inserting `"auto"`, and `KeyCategory.swift` classifies it under `.utility`.
5. **Language Definition Overrides:** Verify `LanguageDefinitions.swift` (English and others) correctly populates `centerCharacters` as a 3×4 matrix and maps directional overrides strictly to `.swipeUp` and `.swipeDown` for `r0c0` through `r2c3`.
6. **Numeric Layer Integration:** Verify `NumericLayouts.swift` uses `"ABC"` as the back-to-alpha label and includes `UtilitySlot.clipboard` in its utility key set.
|7. **Shift Behavior:** Shift is on `r2c0.swipeUp`. A full mode toggle (main → shifted → capsLock) with auto-transition back to main after typing a letter. Caps Lock's swipeUp cycles back to main (no dead-end mode).

---

## 5. Implementation Reference

### 5.1 Files Modified

| File | Purpose |
|------|---------|
| `Definition/Layout/GridSlot.swift` | Added coordinate-based slot IDs (`r0c0`–`r3c3`), kept legacy names for numeric compatibility |
| `Definition/Layout/UtilitySlot.swift` | Added `clipboard` and `autocomplete` identifiers |
| `Definition/Layout/StandardArrangements.swift` | Rewrote portrait/landscape/numeric arrangements for 5-column, 4-row grid |
| `Settings/KeyboardConstants.swift` | Updated `totalRows` from 4 → 5 |
| `Definition/Language/GridKeyboardFactory.swift` | Changed letter key `swipeMode` to `.twoWayVertical`, updated precondition check for 3×4 matrix |
| `Definition/Language/CommonKeys.swift` | Added `clipboard`, `autocomplete`, `r3c0` key configs; rewrote `defaultSlotBindings` for new slots with vertical-only bindings; updated `return` with `.dismissKeyboard` on swipeDown |
| `Definition/Model/KeyAction.swift` | Added `.autocomplete` case |
| `Definition/Model/KeyCategory.swift` | Added `.autocomplete` → `.utility` mapping |
| `Runtime/Pipeline/TextInputMiddleware.swift` | Added `.autocomplete` → `"auto"` insertion |
| `Runtime/Pipeline/AutoCapitalizationMiddleware.swift` | Added `.autocomplete` to `affectsCapitalization` |
| `Definition/Language/KeyboardMode.swift` | Updated `replacingShiftUpBinding` to target `r2c0` instead of `midRight` |
| `Definition/Language/LanguageDefinitions.swift` | All 15 languages: 3×3 → 3×4 center matrices, overrides converted to vertical-only new slots, return/circular overrides stripped |
| `Definition/Language/LanguageDefinitions+MessagEase.swift` | 11 additional layouts (Ukrainian, Greek, Portuguese, Arabic, Persian, Urdu, Thai, Hindi, Hiragana, Katakana, Korean): same transformation |
| `Definition/Language/NumericLayouts.swift` | Changed back-to-alpha label to `"ABC"`, replaced globe with clipboard in utility keys |

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

Every language previously used a 3×3 center matrix. The 4th column is **empty** (`""`) for all non-English languages. This means the slots `r0c3`, `r1c3`, `r2c3` have no tap character for those languages — they function as **swipe-only keys** producing the extra letters that were displaced from horizontal/diagonal swipes.

### 6.2 Extra Letter Assignment

The conversion script applied this priority:
1. **Vertical swipes (.swipeUp, .swipeDown)** stay on their original slot's new coordinate equivalent.
2. **Horizontal/diagonal swipes (.swipeLeft, .swipeRight, .swipeUpLeft, etc.)** are dropped. The first letter from these discarded directions is promoted to the slot in column 3 of the same row (`.swipeUp`), so it remains typeable.

Example — Croatian: `v` (from `topLeft.swipeDownRight`) → `r0c3.swipeUp`, `k` (from `midLeft.swipeRight`) → `r1c3.swipeUp`, `y` (from `bottomLeft.swipeUpRight`) → `r2c3.swipeUp`.

### 6.3 Removed Features

- **Return overrides** referencing old slot names (Hebrew final forms, Arabic script returns) are stripped. These can be re-added per language in a follow-up if needed, using the new slot names.
- **Circular overrides** (numeric layer superscripts like `∫`, `∑`) kept their existing logic — they still use the legacy slot names via `NumericLayouts`.
- **Compose rules** (accent composition via compose engine) are kept and unchanged.

---

## 7. Testing & Build

### 7.1 Build Verification
- The project **builds successfully** against `iPhone 17` simulator target with `xcodebuild build`.
- All `WurstfingerTests` pass (verified via `xcodebuild test`).
- No compiler warnings related to the grid changes.

### 7.2 Runtime Behaviours to Verify (Manual)

1. **Grid rendering:** Open the keyboard in-simulator. Verify 5 columns, 4 letter rows + space/return row render without overlaps or gaps.
2. **Vertical swipe restriction:** Tap a letter key → center character. Swipe up → upper character. Swipe down → lower character. Swipe left/right → should do nothing (no binding).
3. **Shift behaviour:** Swipe up on `r2c0` (S key) → enters shifted mode. Tap any letter → types uppercase, then auto-transitions back to lowercase. Tap shift again → caps lock. Swipe up on shift in caps lock → returns to lowercase.
4. **Clipboard utility:** Tap clipboard key (utility col row 0) → cut. Swipe up → copy. Swipe down → paste.
5. **Autocomplete:** Tap autocomplete key (utility col row 1) → types `"auto"`.
6. **Return key:** Tap → newline. Swipe down → keyboard dismisses.
7. **r3c0 (bottom-left):** Tap → numeric layer. Swipe up → emoji mode (inert). Swipe down → next input method.
8. **Spacebar:** Tap → space. Drag → cursor moves. Long press → zero digit.
9. **Numeric layer:** Verify phone-style digit layout with `"ABC"` toggle, clipboard utility in col 4 row 0, spacebar spanning 2 cols.
10. **Delete key:** Tap → delete one character. Swipe left/right → continuous delete.
11. **Landscape orientation:** Rotate device → same 4×5 grid layout, utility column on leading edge.
12. **Punctuation:** r2c2 swipeUp → `'`, swipeDown → `,`. r2c3 swipeUp → `"`, swipeDown → `.`. r1c0 swipeUp → `!`. r1c3 swipeUp → `?`.
