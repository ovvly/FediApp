import SwiftUI

struct WelcomeView: View {
    let interactor: WelcomeInteractor
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Hi, this app is simple mastodon clinet allowing you to log in to your account on mastodon servers or simply just check how mastodon looks like")
                .font(.title3)
                .fontWeight(.semibold)
            Spacer()
                .frame(height: 60)
            Button {
                interactor.logIn()
            } label: {
                Text("Log in to mastodon server")
            }
            .buttonStyle(PrimaryButtonStyle())
            
            Button {
                interactor.showFeeds()
            } label: {
                Text("Check public feeds")
            }
            .buttonStyle(SecondaryButtonStyle())
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    WelcomeView(interactor: WelcomeInteractorStub())
}

final class WelcomeInteractorStub: WelcomeInteractor {
    func logIn() { }
    func showFeeds() { }
}
