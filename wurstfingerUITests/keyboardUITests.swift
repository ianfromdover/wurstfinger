import XCTest

final class WurstfingerUITests: XCTestCase {

    private var app: XCUIApplication!
    private var textField: XCUIElement!

    enum SwipeDirection {
        case up
        case down
        case left
        case right
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

        // 1. Locate and focus the test host text field to trigger the keyboard
        textField = app.textFields["TestHostTextField"]
        if !textField.exists {
            // Fallback to first text field if identifier isn't set
            textField = app.textFields.element(boundBy: 0)
        }
        
        XCTAssertTrue(textField.waitForExistence(timeout: 5.0), "Test host text field must exist.")
        textField.tap()

        // 2. Wait for the custom keyboard container to render
        let keyboardView = app.otherElements["WurstfingerKeyboardView"]
        XCTAssertTrue(keyboardView.waitForExistence(timeout: 5.0), "Wurstfinger keyboard failed to appear.")
    }

    override func tearDownWithError() throws {
        app = nil
        super.tearDown()
    }

    // MARK: - Gesture Automation Tests

    /// Verifies Tap, Swipe Up, and Swipe Down behaviors on a letter grid slot (r0c0 / 'L' key)
    func testLetterGridTapAndVerticalSwipes() throws {
        let r0c0Key = keyElement(for: "r0c0") // 'L' key

        // 1. Tap -> Center character 'l'
        r0c0Key.tap()
        XCTAssertEqual(textFieldValue, "l", "Tap on r0c0 must insert 'l'")

        // 2. Swipe Up -> Upper character 'w'
        swipe(on: r0c0Key, direction: .up)
        XCTAssertEqual(textFieldValue, "lw", "Swipe Up on r0c0 must insert 'w'")

        // 3. Swipe Down -> Lower character 'v'
        swipe(on: r0c0Key, direction: .down)
        XCTAssertEqual(textFieldValue, "lwv", "Swipe Down on r0c0 must insert 'v'")
    }

    /// Verifies that Horizontal Swipes (Left/Right) on letter keys produce NO output
    func testHorizontalSwipesAreIgnoredOnLetterKeys() throws {
        let r0c0Key = keyElement(for: "r0c0")

        // Baseline string
        r0c0Key.tap()
        let initialText = textFieldValue
        XCTAssertEqual(initialText, "l")

        // 1. Swipe Left -> Must be ignored
        swipe(on: r0c0Key, direction: .left)
        XCTAssertEqual(textFieldValue, initialText, "Swipe Left on letter keys must produce no text input")

        // 2. Swipe Right -> Must be ignored
        swipe(on: r0c0Key, direction: .right)
        XCTAssertEqual(textFieldValue, initialText, "Swipe Right on letter keys must produce no text input")
    }

    /// Verifies Autocomplete button tap (Column 4, Row 1)
    func testAutocompleteUtilityKey() throws {
        let autocompleteKey = app.keys["Utility_autocomplete"]
        XCTAssertTrue(autocompleteKey.exists, "Autocomplete utility key must be present in Column 4")

        autocompleteKey.tap()
        XCTAssertEqual(textFieldValue, "auto", "Tapping autocomplete key must insert 'auto'")
    }

    /// Verifies Shift mode toggle via Swipe Up on r2c0 ('S' key)
    func testShiftToggleAndCapitalization() throws {
        let r2c0Key = keyElement(for: "r2c0") // Shift on Swipe Up
        let r0c1Key = keyElement(for: "r0c1") // 'D' key

        // 1. Swipe Up on r2c0 to activate Shift Mode
        swipe(on: r2c0Key, direction: .up)

        // 2. Tap next letter key ('D') -> Should output uppercase 'D'
        r0c1Key.tap()
        XCTAssertEqual(textFieldValue, "D", "Typing after Shift swipe must produce an uppercase character")

        // 3. Subsequent tap ('D') -> Should auto-revert to lowercase 'd'
        r0c1Key.tap()
        XCTAssertEqual(textFieldValue, "Dd", "Keyboard must auto-transition back to lowercase after typing a letter")
    }

    /// Verifies Return key Swipe Down dismisses the keyboard
    func testReturnKeySwipeDownDismissesKeyboard() throws {
        let returnKey = app.keys["Utility_return"]
        XCTAssertTrue(returnKey.exists, "Return key must be present")

        // Swipe Down on Return Key
        swipe(on: returnKey, direction: .down)

        // Verify keyboard view is no longer visible
        let keyboardView = app.otherElements["WurstfingerKeyboardView"]
        let exists = expectation(for: NSPredicate(format: "exists == false"), evaluatedWith: keyboardView)
        wait(for: [exists], timeout: 3.0)

        XCTAssertFalse(keyboardView.exists, "Swiping down on Return key must dismiss the keyboard")
    }

    // MARK: - Gesture Helper Methods

    /// Performs precise coordinate-based drag gestures on key elements
    private func swipe(on element: XCUIElement, direction: SwipeDirection, duration: TimeInterval = 0.08) {
        let center = element.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        
        let targetOffset: CGVector
        switch direction {
        case .up:
            targetOffset = CGVector(dx: 0.5, dy: -0.6) // Drag above key bounds
        case .down:
            targetOffset = CGVector(dx: 0.5, dy: 1.6)  // Drag below key bounds
        case .left:
            targetOffset = CGVector(dx: -0.6, dy: 0.5) // Drag left of key bounds
        case .right:
            targetOffset = CGVector(dx: 1.6, dy: 0.5)  // Drag right of key bounds
        }

        let targetCoordinate = element.coordinate(withNormalizedOffset: targetOffset)
        center.press(forDuration: duration, thenDragTo: targetCoordinate)
    }

    private func keyElement(for slotID: String) -> XCUIElement {
        let key = app.keys[slotID]
        XCTAssertTrue(key.waitForExistence(timeout: 2.0), "Key element for slot '\(slotID)' not found")
        return key
    }

    private var textFieldValue: String {
        return (textField.value as? String) ?? ""
    }
}
