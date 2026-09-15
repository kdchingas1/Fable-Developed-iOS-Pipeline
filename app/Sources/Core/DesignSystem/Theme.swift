import SwiftUI

/// Design tokens. Values come from `products/<slug>/03-design/design-tokens.md`.
enum Theme {
    enum Spacing {
        static let xs: CGFloat = 4
        static let s: CGFloat = 8
        static let m: CGFloat = 16
        static let l: CGFloat = 24
        static let xl: CGFloat = 32
    }

    enum Radius {
        static let small: CGFloat = 8
        static let card: CGFloat = 12
        static let large: CGFloat = 20
    }

    enum Colors {
        static let accent = Color.accentColor
        static let surface = Color(uiColor: .secondarySystemBackground)
        static let background = Color(uiColor: .systemBackground)
    }
}
