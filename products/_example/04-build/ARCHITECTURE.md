# Architecture — Example App

## Module map
| Module | Path | Responsibility |
|--------|------|----------------|
| App | Sources/App | entry, AppEnvironment, root navigation |
| Core/DesignSystem | Sources/Core/DesignSystem | tokens, reusable views |
| Core/Services | Sources/Core/Services | protocols + live/fake implementations |
| Features/<Feature> | Sources/Features/<Feature> | View, ViewModel, feature-local models |

## Data model
<Entities, persistence (SwiftData / files / UserDefaults), sync>

## Services
| Protocol | Live impl | Fake impl | Notes |
|----------|-----------|-----------|-------|
| PurchaseService | StoreKitPurchaseService | FakePurchaseService | StoreKit 2 |
| AnalyticsService | <vendor>AnalyticsService | LoggingAnalyticsService | events in docs/METRICS.md |
| PersistenceService | | | |

## Dependencies
| Package | Why | Removal plan |
|---------|-----|--------------|

## Build order (vertical slices)
1. Slice 1: <core screen end to end> → TestFlight
2. 
3. 

## Entitlements and review-sensitive features
- 
