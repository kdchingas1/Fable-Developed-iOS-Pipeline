import Foundation
import Observation

@MainActor
@Observable
final class PaywallViewModel {
    enum State: Equatable {
        case loading
        case loaded([PurchasableProduct])
        case failed(String)
    }

    private(set) var state: State = .loading
    private(set) var isPurchasing = false
    private(set) var didUnlock = false
    var errorMessage: String?

    private let purchases: any PurchaseService
    private let analytics: any AnalyticsService

    init(purchases: any PurchaseService, analytics: any AnalyticsService) {
        self.purchases = purchases
        self.analytics = analytics
    }

    func load() async {
        analytics.track(.paywallViewed)
        do {
            let products = try await purchases.products()
            state = .loaded(products)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }

    func purchase(_ product: PurchasableProduct) async {
        isPurchasing = true
        defer { isPurchasing = false }
        analytics.track(.purchaseStarted, properties: ["product": product.id])
        do {
            try await purchases.purchase(product.id)
            didUnlock = await purchases.isPro
            analytics.track(.purchaseCompleted, properties: ["product": product.id])
        } catch PurchaseError.cancelled {
            // User backed out; not an error worth surfacing.
        } catch {
            errorMessage = String(localized: "Purchase failed. Please try again.")
            analytics.track(.purchaseFailed, properties: ["product": product.id])
        }
    }

    func restore() async {
        isPurchasing = true
        defer { isPurchasing = false }
        do {
            try await purchases.restore()
            didUnlock = await purchases.isPro
            analytics.track(.restoreCompleted)
            if !didUnlock {
                errorMessage = String(localized: "No previous purchase found.")
            }
        } catch {
            errorMessage = String(localized: "Restore failed. Please try again.")
        }
    }
}
