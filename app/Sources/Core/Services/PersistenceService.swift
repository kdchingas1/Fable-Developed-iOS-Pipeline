import Foundation

enum PersistenceKey: String, Sendable {
    case hasCompletedOnboarding
    case itemCount
}

/// Small key-value boundary. Products that need a real store add SwiftData behind a separate protocol.
protocol PersistenceService: Sendable {
    func bool(forKey key: PersistenceKey) -> Bool
    func set(_ value: Bool, forKey key: PersistenceKey)
    func integer(forKey key: PersistenceKey) -> Int
    func set(_ value: Int, forKey key: PersistenceKey)
}

final class UserDefaultsPersistenceService: PersistenceService, @unchecked Sendable {
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func bool(forKey key: PersistenceKey) -> Bool { defaults.bool(forKey: key.rawValue) }
    func set(_ value: Bool, forKey key: PersistenceKey) { defaults.set(value, forKey: key.rawValue) }
    func integer(forKey key: PersistenceKey) -> Int { defaults.integer(forKey: key.rawValue) }
    func set(_ value: Int, forKey key: PersistenceKey) { defaults.set(value, forKey: key.rawValue) }
}

final class InMemoryPersistenceService: PersistenceService, @unchecked Sendable {
    private let lock = NSLock()
    private var storage: [String: Any] = [:]

    func bool(forKey key: PersistenceKey) -> Bool { lock.withLock { storage[key.rawValue] as? Bool ?? false } }
    func set(_ value: Bool, forKey key: PersistenceKey) { lock.withLock { storage[key.rawValue] = value } }
    func integer(forKey key: PersistenceKey) -> Int { lock.withLock { storage[key.rawValue] as? Int ?? 0 } }
    func set(_ value: Int, forKey key: PersistenceKey) { lock.withLock { storage[key.rawValue] = value } }
}
