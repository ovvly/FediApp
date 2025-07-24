import SwiftUI

struct WelcomeView: View {
    let interactor: WelcomeInteractor
    
    var body: some View {
        VStack(spacing: 20) {
            Button {
                interactor.logIn()
            } label: {
                Text("Log in")
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(.horizontal, 20)
            
            
            Button {
                interactor.showFeeds()
            } label: {
                Text("Show me some public feeds")
            }
            .buttonStyle(SecondaryButtonStyle())
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    WelcomeView(interactor: WelcomeInteractorStub())
}

final class WelcomeInteractorStub: WelcomeInteractor {
    func logIn() { }
    func showFeeds() { }
}
