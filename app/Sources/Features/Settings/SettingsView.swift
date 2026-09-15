import SwiftUI

struct SettingsView: View {
    @Environment(AppEnvironment.self) private var env
    @State var viewModel: SettingsViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section(String(localized: "Plan")) {
                    if viewModel.isPro {
                        Label(String(localized: "Pro active"), systemImage: "checkmark.seal.fill")
                    } else {
                        Button(String(localized: "Upgrade to Pro")) { viewModel.showPaywall = true }
                    }
                }
                Section(String(localized: "About")) {
                    Link(String(localized: "Privacy policy"), destination: Links.privacy)
                    Link(String(localized: "Support"), destination: Links.support)
                    LabeledContent(String(localized: "Version"), value: Bundle.main.versionString)
                }
                #if DEBUG
                    Section("Debug") {
                        Button("Reset onboarding") { viewModel.resetOnboarding() }
                    }
                #endif
            }
            .navigationTitle(String(localized: "Settings"))
            .task { await viewModel.refresh() }
            .sheet(isPresented: $viewModel.showPaywall, onDismiss: { Task { await viewModel.refresh() } }) {
                PaywallView(viewModel: PaywallViewModel(purchases: env.purchases, analytics: env.analytics))
            }
        }
    }
}

extension Bundle {
    var versionString: String {
        let version = infoDictionary?["CFBundleShortVersionString"] as? String ?? "0"
        let build = infoDictionary?["CFBundleVersion"] as? String ?? "0"
        return "\(version) (\(build))"
    }
}

#Preview {
    let env = AppEnvironment.preview()
    SettingsView(viewModel: SettingsViewModel(purchases: env.purchases, persistence: env.persistence))
        .environment(env)
}
