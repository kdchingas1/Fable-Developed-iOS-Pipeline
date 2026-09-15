# App architecture

Applies to `app/` and every `products/<slug>/04-build/app/` derived from it.

## Principles

1. **SwiftUI + Observation.** Views are thin; ViewModels are `@MainActor @Observable` classes
   holding all state and logic. No `ObservableObject`, no Combine unless a framework forces it.
2. **Protocols at every boundary.** Purchases, analytics, persistence, and networking are
   protocols in `Sources/Core/Services/` with a live and a fake implementation. ViewModels are
   tested with fakes; no test touches StoreKit or the network.
3. **One composition root.** `AppEnvironment` builds every service once and is injected via
   `.environment(...)`. Features never construct services.
4. **Feature folders.** `Sources/Features/<Name>/` holds `<Name>View.swift`,
   `<Name>ViewModel.swift`, and feature-local models. Cross-feature code moves to `Core`.
5. **Strict concurrency.** Swift 6 language mode with complete checking. Services are
   `Sendable`; ViewModels are `@MainActor`. Concurrency warnings are build errors.
6. **Generated project.** `project.yml` is the source of truth. The `.xcodeproj` is never
   committed. Adding a file means adding it to the folder; XcodeGen picks it up.

## Data

- Default: `UserDefaults` behind `PersistenceService` for flags and small values.
- Structured data: SwiftData behind a product-specific protocol (add in Stage 4 architecture).
- Sync: CloudKit via SwiftData when the PRD requires multi-device; otherwise none.
- Never store secrets in the app. Keys for analytics vendors go in `Config/*.xcconfig` and
  are read from `Info.plist`, and are treated as public.

## Purchases

StoreKit 2 only. `StoreKitPurchaseService` handles products, purchase, entitlement check via
`Transaction.currentEntitlements`, and restore via `AppStore.sync()`. Product IDs live in one
`ProductID` enum and must match `Config/Products.storekit` and App Store Connect.

## Analytics

`AnalyticsEvent` enumerates the pipeline's required events. Products add their own cases.
The default `LoggingAnalyticsService` writes to OSLog; swap in a vendor wrapper in Stage 4.

## Minimum OS

iOS 18.0 by default (`project.yml`). Rationale: `@Observable`, `Tab` API, and SwiftData
maturity. Raise when a product needs newer APIs; lower only with a written reason.

## Testing

- Unit: Swift Testing, `Tests/AppTests/`, one file per ViewModel, uses fakes from `Core/Services`.
- UI: XCTest, `UITests/AppUITests/`, golden path plus `ScreenshotTests` for fastlane.
- Launch arguments `-hasCompletedOnboarding` and `-itemCount` seed `UserDefaults` for UI tests.
