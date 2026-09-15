import Foundation
import Observation

/// Single composition root. Every service the app needs is created here and injected
/// through the SwiftUI environment. Tests and previews use `.preview()`.
@MainActor
@Observable
final class AppEnvironment {
    let purchases: any PurchaseService
    let analytics: any AnalyticsService
    let persistence: any PersistenceService

    init(
        purchases: any PurchaseService,
        analytics: any AnalyticsService,
        persistence: any PersistenceService
    ) {
        self.purchases = purchases
        self.analytics = analytics
        self.persistence = persistence
    }

    static func live() -> AppEnvironment {
        AppEnvironment(
            purchases: StoreKitPurchaseService(productIDs: ProductID.all),
            analytics: LoggingAnalyticsService(),
            persistence: UserDefaultsPersistenceService()
        )
    }

    static func preview(isPro: Bool = false) -> AppEnvironment {
        AppEnvironment(
            purchases: FakePurchaseService(isPro: isPro),
            analytics: LoggingAnalyticsService(),
            persistence: InMemoryPersistenceService()
        )
    }
}
