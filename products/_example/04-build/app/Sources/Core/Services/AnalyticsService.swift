import Foundation
import OSLog

/// Events the pipeline requires. See `docs/METRICS.md` for definitions.
enum AnalyticsEvent: String, Sendable {
    case appOpened = "app_opened"
    case onboardingCompleted = "onboarding_completed"
    case activated = "activated" // first value moment, defined per product in the PRD
    case coreActionCompleted = "core_action_completed"
    case paywallViewed = "paywall_viewed"
    case purchaseStarted = "purchase_started"
    case purchaseCompleted = "purchase_completed"
    case purchaseFailed = "purchase_failed"
    case restoreCompleted = "restore_completed"
}

protocol AnalyticsService: Sendable {
    func track(_ event: AnalyticsEvent, properties: [String: String])
}

extension AnalyticsService {
    func track(_ event: AnalyticsEvent) {
        track(event, properties: [:])
    }
}

/// Default implementation logs to the unified logging system. Replace with a vendor SDK
/// wrapper (TelemetryDeck, PostHog, Firebase) when the product chooses one in Stage 4.
final class LoggingAnalyticsService: AnalyticsService, @unchecked Sendable {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "app", category: "analytics")

    func track(_ event: AnalyticsEvent, properties: [String: String]) {
        logger.info("event=\(event.rawValue, privacy: .public) props=\(properties.description, privacy: .public)")
    }
}
