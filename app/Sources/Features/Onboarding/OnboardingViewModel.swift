import Foundation
import Observation

@MainActor
@Observable
final class OnboardingViewModel {
    struct Page: Identifiable, Equatable {
        let id: Int
        let systemImage: String
        let title: String
        let message: String
    }

    let pages: [Page] = [
        Page(
            id: 0,
            systemImage: "sparkles",
            title: String(localized: "Welcome"),
            message: String(localized: "One sentence on the job this app does.")
        ),
        Page(
            id: 1,
            systemImage: "bolt.fill",
            title: String(localized: "Fast"),
            message: String(localized: "One sentence on the core benefit.")
        ),
        Page(
            id: 2,
            systemImage: "lock.shield",
            title: String(localized: "Private"),
            message: String(localized: "Your data stays on your device.")
        ),
    ]
    var currentPage = 0

    private let persistence: any PersistenceService
    private let analytics: any AnalyticsService

    init(persistence: any PersistenceService, analytics: any AnalyticsService) {
        self.persistence = persistence
        self.analytics = analytics
    }

    var isLastPage: Bool { currentPage == pages.count - 1 }

    func advance() -> Bool {
        if isLastPage {
            complete()
            return true
        }
        currentPage += 1
        return false
    }

    func complete() {
        persistence.set(true, forKey: .hasCompletedOnboarding)
        analytics.track(.onboardingCompleted)
    }
}
