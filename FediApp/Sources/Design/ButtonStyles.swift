import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(height: 48)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(24)
            .font(.system(size: 16.0, weight: .semibold, design: .default))
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(height: 48)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(24)
            .font(.system(size: 16.0, weight: .semibold, design: .default))
    }
}


#Preview {
    Button("Primary", action: {})
        .buttonStyle(PrimaryButtonStyle())
    Button("Secondary", action: {})
        .buttonStyle(SecondaryButtonStyle())
}
