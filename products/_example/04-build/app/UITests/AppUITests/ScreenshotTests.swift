import XCTest

/// Captures App Store screenshots. Frames follow `products/<slug>/06-launch/screenshot-storyboard.md`.
/// For `fastlane screenshots`, run `bundle exec fastlane snapshot init` once to add SnapshotHelper.swift
/// to this target, then replace `capture(_:name:)` calls with fastlane's `snapshot("01-Home")`.
final class ScreenshotTests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments += ["-hasCompletedOnboarding", "YES", "-itemCount", "12"]
        app.launch()
    }

    func testCaptureScreenshots() {
        let app = XCUIApplication()
        capture(app, name: "01-Home")
        app.tabBars.buttons.element(boundBy: 1).tap()
        capture(app, name: "02-Settings")
    }

    private func capture(_ app: XCUIApplication, name: String) {
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
