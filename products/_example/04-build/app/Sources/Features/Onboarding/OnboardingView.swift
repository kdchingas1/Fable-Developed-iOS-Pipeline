import SwiftUI

struct OnboardingView: View {
    @State var viewModel: OnboardingViewModel
    let onFinish: () -> Void

    var body: some View {
        VStack {
            TabView(selection: $viewModel.currentPage) {
                ForEach(viewModel.pages) { page in
                    VStack(spacing: Theme.Spacing.l) {
                        Image(systemName: page.systemImage)
                            .font(.system(size: 64))
                            .foregroundStyle(Theme.Colors.accent)
                            .accessibilityHidden(true)
                        Text(page.title).font(.largeTitle.bold())
                        Text(page.message).font(.body).multilineTextAlignment(.center)
                    }
                    .padding(Theme.Spacing.xl)
                    .tag(page.id)
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))

            PrimaryButton(title: viewModel.isLastPage ? String(localized: "Get started") : String(localized: "Continue")) {
                if viewModel.advance() { onFinish() }
            }
            .padding(Theme.Spacing.l)

            Button(String(localized: "Skip")) {
                viewModel.complete()
                onFinish()
            }
            .font(.footnote)
            .padding(.bottom, Theme.Spacing.m)
        }
    }
}

#Preview {
    let env = AppEnvironment.preview()
    OnboardingView(viewModel: OnboardingViewModel(persistence: env.persistence, analytics: env.analytics)) {}
}
