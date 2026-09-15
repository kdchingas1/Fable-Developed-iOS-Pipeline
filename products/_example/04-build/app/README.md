# App template

A production-ready SwiftUI starting point. `scripts/new-product.sh` copies this directory into
`products/<slug>/04-build/app/`; edit it there, not here, unless you are improving the template.

## Stack

- Swift 6, strict concurrency, SwiftUI, `@Observable` ViewModels
- XcodeGen (`project.yml`) generates the `.xcodeproj`; the project file is not committed
- Swift Testing for unit tests, XCTest for UI tests and screenshots
- StoreKit 2 behind `PurchaseService`; local `Config/Products.storekit` for simulator testing
- SwiftLint + SwiftFormat, enforced by the repo hook and CI

## Commands

```bash
xcodegen generate
open App.xcodeproj
xcodebuild -scheme App -destination 'platform=iOS Simulator,name=iPhone 16' -quiet test
swiftformat . && swiftlint --strict
```

## Layout

```
Sources/
  App/                 AppMain, AppEnvironment, RootView, assets
  Core/DesignSystem/   Theme tokens, shared views
  Core/Services/       Protocols + live and fake implementations
  Features/<Name>/     View + ViewModel (+ feature-local models)
Tests/AppTests/        Swift Testing unit tests, one file per ViewModel
UITests/AppUITests/    Golden path + screenshot capture for fastlane
Config/                xcconfig, StoreKit configuration, Info.plist additions
```
