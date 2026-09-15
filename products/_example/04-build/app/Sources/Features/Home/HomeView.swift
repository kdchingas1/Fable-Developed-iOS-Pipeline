import SwiftUI

struct HomeView: View {
    @State var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isEmpty {
                    EmptyStateView(
                        systemImage: "sparkles",
                        title: String(localized: "Nothing here yet"),
                        message: String(localized: "Tap the button to do the thing this app is for."),
                        actionTitle: String(localized: "Do the thing")
                    ) {
                        viewModel.performCoreAction()
                    }
                } else {
                    VStack(spacing: Theme.Spacing.l) {
                        Text("\(viewModel.itemCount)")
                            .font(.system(size: 72, weight: .bold, design: .rounded))
                            .accessibilityLabel(String(localized: "Count \(viewModel.itemCount)"))
                        PrimaryButton(title: String(localized: "Do it again")) {
                            viewModel.performCoreAction()
                        }
                        .padding(.horizontal, Theme.Spacing.xl)
                    }
                }
            }
            .navigationTitle(String(localized: "Home"))
        }
    }
}

#Preview("Empty") {
    let env = AppEnvironment.preview()
    HomeView(viewModel: HomeViewModel(persistence: env.persistence, analytics: env.analytics))
}
