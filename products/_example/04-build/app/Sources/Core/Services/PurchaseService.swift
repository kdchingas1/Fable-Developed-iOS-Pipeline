import Foundation
import StoreKit

/// Product identifiers. Keep in sync with `Config/Products.storekit` and App Store Connect.
enum ProductID {
    static let proMonthly = "com.example.example.pro.monthly"
    static let proYearly = "com.example.example.pro.yearly"
    static let lifetime = "com.example.example.lifetime"
    static let all: Set<String> = [proMonthly, proYearly, lifetime]
}

enum PurchaseError: Error, Equatable {
    case cancelled
    case pending
    case unverified
    case unknown(String)
}

struct PurchasableProduct: Identifiable, Equatable, Sendable {
    let id: String
    let displayName: String
    let displayPrice: String
    let isSubscription: Bool
}

/// Boundary for all StoreKit access. ViewModels depend on this protocol, never on StoreKit directly.
protocol PurchaseService: Sendable {
    var isPro: Bool { get async }
    func products() async throws -> [PurchasableProduct]
    func purchase(_ productID: String) async throws
    func restore() async throws
}

// MARK: - Live

final class StoreKitPurchaseService: PurchaseService, Sendable {
    private let productIDs: Set<String>

    init(productIDs: Set<String>) {
        self.productIDs = productIDs
    }

    var isPro: Bool {
        get async {
            for await result in Transaction.currentEntitlements {
                if case let .verified(transaction) = result,
                   productIDs.contains(transaction.productID),
                   transaction.revocationDate == nil {
                    return true
                }
            }
            return false
        }
    }

    func products() async throws -> [PurchasableProduct] {
        try await Product.products(for: productIDs).map {
            PurchasableProduct(
                id: $0.id,
                displayName: $0.displayName,
                displayPrice: $0.displayPrice,
                isSubscription: $0.type == .autoRenewable
            )
        }
        .sorted { $0.id < $1.id }
    }

    func purchase(_ productID: String) async throws {
        guard let product = try await Product.products(for: [productID]).first else {
            throw PurchaseError.unknown("Product not found: \(productID)")
        }
        let result = try await product.purchase()
        switch result {
        case let .success(verification):
            guard case let .verified(transaction) = verification else { throw PurchaseError.unverified }
            await transaction.finish()
        case .userCancelled:
            throw PurchaseError.cancelled
        case .pending:
            throw PurchaseError.pending
        @unknown default:
            throw PurchaseError.unknown("Unhandled purchase result")
        }
    }

    func restore() async throws {
        try await AppStore.sync()
    }
}

// MARK: - Fake

/// Deterministic implementation for tests and previews.
final class FakePurchaseService: PurchaseService, @unchecked Sendable {
    private let lock = NSLock()
    private var proState: Bool
    var purchaseError: PurchaseError?
    private(set) var purchasedIDs: [String] = []

    init(isPro: Bool = false) {
        proState = isPro
    }

    var isPro: Bool {
        get async { lock.withLock { proState } }
    }

    func products() async throws -> [PurchasableProduct] {
        [
            .fixture(id: ProductID.proMonthly, name: "Pro Monthly", price: "$4.99", subscription: true),
            .fixture(id: ProductID.proYearly, name: "Pro Yearly", price: "$29.99", subscription: true),
            .fixture(id: ProductID.lifetime, name: "Lifetime", price: "$29.99", subscription: false),
        ]
    }

    func purchase(_ productID: String) async throws {
        if let purchaseError { throw purchaseError }
        lock.withLock {
            purchasedIDs.append(productID)
            proState = true
        }
    }

    func restore() async throws {
        if let purchaseError { throw purchaseError }
    }
}

extension PurchasableProduct {
    /// Convenience for fakes, previews, and tests.
    static func fixture(id: String, name: String, price: String, subscription: Bool) -> PurchasableProduct {
        PurchasableProduct(id: id, displayName: name, displayPrice: price, isSubscription: subscription)
    }
}
