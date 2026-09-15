import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var isLoading = false

    var body: some View {
        Button(action: action) {
            ZStack {
                Text(title).opacity(isLoading ? 0 : 1)
                if isLoading { ProgressView() }
            }
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, Theme.Spacing.m)
        }
        .buttonStyle(.borderedProminent)
        .clipShape(RoundedRectangle(cornerRadius: Theme.Radius.card))
        .disabled(isLoading)
        .accessibilityLabel(title)
    }
}

#Preview {
    VStack(spacing: Theme.Spacing.m) {
        PrimaryButton(title: "Continue") {}
        PrimaryButton(title: "Loading", action: {}, isLoading: true)
    }
    .padding()
}
