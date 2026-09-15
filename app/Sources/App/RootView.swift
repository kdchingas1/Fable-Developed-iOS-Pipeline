import SwiftUI

struct RootView: View {
    @Environment(AppEnvironment.self) private var env
    @State private var showOnboarding = false

    var body: some View {
        TabView {
            Tab(String(localized: "Home"), systemImage: "house") {
                HomeView(viewModel: HomeViewModel(persistence: env.persistence, analytics: env.analytics))
            }
            Tab(String(localized: "Settings"), systemImage: "gearshape") {
                SettingsView(viewModel: SettingsViewModel(purchases: env.purchases, persistence: env.persistence))
            }
        }
        .task {
            showOnboarding = !env.persistence.bool(forKey: .hasCompletedOnboarding)
            env.analytics.track(.appOpened)
        }
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingView(viewModel: OnboardingViewModel(persistence: env.persistence, analytics: env.analytics)) {
                showOnboarding = false
            }
        }
    }
}

#Preview {
    RootView().environment(AppEnvironment.preview())
}
