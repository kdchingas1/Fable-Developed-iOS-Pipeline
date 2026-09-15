@testable import App
import Testing

@MainActor
struct PaywallViewModelTests {
    @Test func loadsProductsAndTracksView() async {
        let analytics = RecordingAnalyticsService()
        let sut = PaywallViewModel(purchases: FakePurchaseService(), analytics: analytics)

        await sut.load()

        guard case let .loaded(products) = sut.state else {
            Issue.record("Expected loaded state, got \(sut.state)")
            return
        }
        #expect(products.count == 3)
        #expect(analytics.has(.paywallViewed))
    }

    @Test func successfulPurchaseUnlocks() async {
        let purchases = FakePurchaseService()
        let analytics = RecordingAnalyticsService()
        let sut = PaywallViewModel(purchases: purchases, analytics: analytics)
        await sut.load()

        await sut.purchase(.fixture(id: ProductID.proYearly, name: "Pro Yearly", price: "$29.99", subscription: true))

        #expect(sut.didUnlock)
        #expect(sut.errorMessage == nil)
        #expect(analytics.has(.purchaseCompleted))
    }

    @Test func cancelledPurchaseIsSilent() async {
        let purchases = FakePurchaseService()
        purchases.purchaseError = .cancelled
        let sut = PaywallViewModel(purchases: purchases, analytics: RecordingAnalyticsService())

        await sut.purchase(.fixture(id: ProductID.lifetime, name: "Lifetime", price: "$29.99", subscription: false))

        #expect(!sut.didUnlock)
        #expect(sut.errorMessage == nil)
    }

    @Test func failedPurchaseShowsError() async {
        let purchases = FakePurchaseService()
        purchases.purchaseError = .unverified
        let analytics = RecordingAnalyticsService()
        let sut = PaywallViewModel(purchases: purchases, analytics: analytics)

        await sut.purchase(.fixture(id: ProductID.lifetime, name: "Lifetime", price: "$29.99", subscription: false))

        #expect(sut.errorMessage != nil)
        #expect(analytics.has(.purchaseFailed))
    }

    @Test func restoreWithoutPurchaseReportsNothingFound() async {
        let sut = PaywallViewModel(purchases: FakePurchaseService(isPro: false), analytics: RecordingAnalyticsService())
        await sut.restore()
        #expect(!sut.didUnlock)
        #expect(sut.errorMessage != nil)
    }
}
