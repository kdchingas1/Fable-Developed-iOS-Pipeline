import SwiftUI

/// Standard empty state. Every list or fetch in the app uses this or a variant of it.
struct EmptyStateView: View {
    let systemImage: String
    let title: String
    let message: String
    var actionTitle: String?
    var action: (() -> Void)?

    var body: some View {
        ContentUnavailableView {
            Label(title, systemImage: systemImage)
        } description: {
            Text(message)
        } actions: {
            if let actionTitle, let action {
                Button(actionTitle, action: action).buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    EmptyStateView(systemImage: "tray", title: "Nothing yet", message: "Add your first item to get started.", actionTitle: "Add") {}
}
