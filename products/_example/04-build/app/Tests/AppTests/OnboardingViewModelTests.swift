@testable import App
import Testing

@MainActor
struct OnboardingViewModelTests {
    @Test func advancesThroughPagesThenCompletes() {
        let persistence = InMemoryPersistenceService()
        let analytics = RecordingAnalyticsService()
        let sut = OnboardingViewModel(persistence: persistence, analytics: analytics)

        #expect(!sut.advance())
        #expect(!sut.advance())
        #expect(sut.isLastPage)
        #expect(sut.advance())

        #expect(persistence.bool(forKey: .hasCompletedOnboarding))
        #expect(analytics.has(.onboardingCompleted))
    }
}
