import Foundation
import Observation

/// Placeholder core loop: a counter standing in for the product's real core action.
/// Replace `Item` and `performCoreAction` with the product's domain in Stage 4 slice 1.
@MainActor
@Observable
final class HomeViewModel {
    private(set) var itemCount: Int
    private let persistence: any PersistenceService
    private let analytics: any AnalyticsService

    init(persistence: any PersistenceService, analytics: any AnalyticsService) {
        self.persistence = persistence
        self.analytics = analytics
        itemCount = persistence.integer(forKey: .itemCount)
    }

    var isEmpty: Bool { itemCount == 0 }

    func performCoreAction() {
        let wasEmpty = isEmpty
        itemCount += 1
        persistence.set(itemCount, forKey: .itemCount)
        analytics.track(.coreActionCompleted, properties: ["count": String(itemCount)])
        if wasEmpty {
            analytics.track(.activated)
        }
    }
}
