import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(height: 48)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.mastodonViolet)
            .cornerRadius(4)
            .font(.system(size: 16.0, weight: .bold, design: .default))
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(height: 48)
            .frame(maxWidth: .infinity)
            .foregroundColor(.mastodonViolet)
            .background(Color.white)
            .cornerRadius(4)
            .font(.system(size: 16.0, weight: .bold, design: .default))
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.mastodonViolet, lineWidth: 2)
            )
    }
}

#Preview {
    VStack {
        Button("Primary", action: {})
            .buttonStyle(PrimaryButtonStyle())
        Button("Secondary", action: {})
            .buttonStyle(SecondaryButtonStyle())
    }.padding()
}
