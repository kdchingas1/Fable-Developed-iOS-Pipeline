# Design tokens — Example App

## Color
| Token | Light | Dark | Use |
|-------|-------|------|-----|
| accent | | | buttons, links |
| background | systemBackground | systemBackground | |
| surface | secondarySystemBackground | | cards |
| textPrimary | label | label | |
| textSecondary | secondaryLabel | | |
| success / warning / danger | | | |

## Type (Dynamic Type)
| Token | Style | Weight |
|-------|-------|--------|
| display | largeTitle | bold |
| title | title2 | semibold |
| body | body | regular |
| caption | caption | regular |

## Spacing: 4, 8, 12, 16, 24, 32   Radii: 8, 12, 20   Icons: SF Symbols

## Swift sketch
```swift
enum Theme {
    enum Color { static let accent = SwiftUI.Color("Accent") }
    enum Spacing { static let s: CGFloat = 8; static let m: CGFloat = 16; static let l: CGFloat = 24 }
    enum Radius { static let card: CGFloat = 12 }
}
```
