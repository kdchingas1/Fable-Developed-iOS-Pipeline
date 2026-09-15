@testable import App
import Foundation

/// Records events so tests can assert on analytics without a vendor SDK.
final class RecordingAnalyticsService: AnalyticsService, @unchecked Sendable {
    private let lock = NSLock()
    private(set) var events: [(AnalyticsEvent, [String: String])] = []

    func track(_ event: AnalyticsEvent, properties: [String: String]) {
        lock.withLock { events.append((event, properties)) }
    }

    func has(_ event: AnalyticsEvent) -> Bool {
        lock.withLock { events.contains { $0.0 == event } }
    }
}
