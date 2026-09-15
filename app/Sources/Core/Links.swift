import Foundation

/// External URLs. Replace the example.com values per product in Stage 4.
enum Links {
    static let terms = url("https://example.com/terms")
    static let privacy = url("https://example.com/privacy")
    static let support = url("https://example.com/support")

    private static func url(_ literal: StaticString) -> URL {
        guard let url = URL(string: "\(literal)") else {
            preconditionFailure("Invalid URL literal: \(literal)")
        }
        return url
    }
}
