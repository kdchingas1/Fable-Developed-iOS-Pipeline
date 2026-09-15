@testable import App
import Testing

@MainActor
struct HomeViewModelTests {
    @Test func startsEmptyAndActivatesOnFirstAction() {
        let analytics = RecordingAnalyticsService()
        let sut = HomeViewModel(persistence: InMemoryPersistenceService(), analytics: analytics)

        #expect(sut.isEmpty)
        sut.performCoreAction()

        #expect(sut.itemCount == 1)
        #expect(analytics.has(.activated))
        #expect(analytics.has(.coreActionCompleted))
    }

    @Test func activatesOnlyOnce() {
        let analytics = RecordingAnalyticsService()
        let sut = HomeViewModel(persistence: InMemoryPersistenceService(), analytics: analytics)

        sut.performCoreAction()
        sut.performCoreAction()

        #expect(analytics.events.filter { $0.0 == .activated }.count == 1)
    }

    @Test func persistsCount() {
        let persistence = InMemoryPersistenceService()
        HomeViewModel(persistence: persistence, analytics: RecordingAnalyticsService()).performCoreAction()

        let reloaded = HomeViewModel(persistence: persistence, analytics: RecordingAnalyticsService())
        #expect(reloaded.itemCount == 1)
    }
}
