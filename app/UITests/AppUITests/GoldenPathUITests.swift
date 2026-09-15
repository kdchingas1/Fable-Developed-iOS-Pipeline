import XCTest

final class GoldenPathUITests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false
    }

    func testOnboardingToFirstValue() {
        let app = XCUIApplication()
        app.launchArguments += ["-hasCompletedOnboarding", "NO", "-itemCount", "0"]
        app.launch()

        let skip = app.buttons["Skip"]
        if skip.waitForExistence(timeout: 3) { skip.tap() }

        let cta = app.buttons["Do the thing"]
        XCTAssertTrue(cta.waitForExistence(timeout: 3))
        cta.tap()
        XCTAssertTrue(app.staticTexts["1"].waitForExistence(timeout: 2))
    }
}
