import Foundation
import Observation

@MainActor
@Observable
final class SettingsViewModel {
    private(set) var isPro = false
    var showPaywall = false

    private let purchases: any PurchaseService
    private let persistence: any PersistenceService

    init(purchases: any PurchaseService, persistence: any PersistenceService) {
        self.purchases = purchases
        self.persistence = persistence
    }

    func refresh() async {
        isPro = await purchases.isPro
    }

    func resetOnboarding() {
        persistence.set(false, forKey: .hasCompletedOnboarding)
    }
}
