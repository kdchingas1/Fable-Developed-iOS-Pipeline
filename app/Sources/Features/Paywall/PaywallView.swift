import SwiftUI

struct PaywallView: View {
    @State var viewModel: PaywallViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: Theme.Spacing.l) {
                Text(String(localized: "Unlock Pro"))
                    .font(.largeTitle.bold())
                VStack(alignment: .leading, spacing: Theme.Spacing.s) {
                    Label(String(localized: "Benefit one"), systemImage: "checkmark.circle.fill")
                    Label(String(localized: "Benefit two"), systemImage: "checkmark.circle.fill")
                    Label(String(localized: "Benefit three"), systemImage: "checkmark.circle.fill")
                }
                .font(.body)

                switch viewModel.state {
                case .loading:
                    ProgressView()
                case let .failed(message):
                    EmptyStateView(
                        systemImage: "wifi.exclamationmark",
                        title: String(localized: "Couldn't load plans"),
                        message: message,
                        actionTitle: String(localized: "Retry")
                    ) {
                        Task { await viewModel.load() }
                    }
                case let .loaded(products):
                    ForEach(products) { product in
                        PrimaryButton(title: "\(product.displayName) · \(product.displayPrice)", action: {
                            Task { await viewModel.purchase(product) }
                        }, isLoading: viewModel.isPurchasing)
                    }
                }

                Button(String(localized: "Restore purchases")) {
                    Task { await viewModel.restore() }
                }
                .font(.footnote)

                HStack(spacing: Theme.Spacing.m) {
                    Link(String(localized: "Terms"), destination: Links.terms)
                    Link(String(localized: "Privacy"), destination: Links.privacy)
                }
                .font(.caption)
            }
            .padding(Theme.Spacing.l)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(String(localized: "Not now")) { dismiss() }
                }
            }
            .task { await viewModel.load() }
            .onChange(of: viewModel.didUnlock) { _, unlocked in
                if unlocked { dismiss() }
            }
            .alert(String(localized: "Error"), isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil } }
            )) {
                Button(String(localized: "OK"), role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }
}

#Preview {
    let env = AppEnvironment.preview()
    PaywallView(viewModel: PaywallViewModel(purchases: env.purchases, analytics: env.analytics))
}
