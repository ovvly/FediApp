import SwiftUI

struct LoginView: View {
    @ObservedObject var state: LoginState
    let interactor: LoginInteractor
    
    var body: some View {
        VStack {
            HStack {
                TextField("provide mastodon server url", text: $state.serverUrl)
                    .padding()
                    .border(.gray)
                Button(action: {
                    interactor.login()
                }, label: {
                    Text("Login")
                })
            }
            .padding()
            
            Button(action: {
                interactor.loginToPolSocial()
            }, label: {
                Text("Login to pol.social")
            })
            .buttonStyle(PrimaryButtonStyle())
            .padding(.horizontal)
        }
    }
}

#Preview {
    LoginView(state: .init(), interactor: LoginInteractorStub())
}

final class LoginInteractorStub: LoginInteractor {
    func login() { }
    func loginToPolSocial() { }
}
