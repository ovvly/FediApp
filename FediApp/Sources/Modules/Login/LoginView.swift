import SwiftUI

struct LoginView: View {
    var state: LoginState
    let interactor: LoginInteractor
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    TextField("provide mastodon server url", text: Bindable(state).serverUrl)
                        .padding()
                        .border(.gray)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    Button(action: {
                        interactor.login()
                    }, label: {
                        if state.isLoading {
                            ProgressView()
                        } else {
                            Text("Login")
                        }
                    })
                }
                .padding()
                
                if !state.isLoading {
                    Button(action: {
                        interactor.loginToPolSocial()
                    }, label: {
                        Text("Login to pol.social")
                    })
                    .buttonStyle(PrimaryButtonStyle())
                    .padding(.horizontal)
                } else {
                    Spacer()
                        .frame(height: 56)
                }
            }
            if let error = state.error {
                VStack {
                    Text(error)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                    Spacer()
                }
            }
        }
    }
}

#Preview("Ready") {
    LoginView(state: .ready, interactor: LoginInteractorStub())
}

#Preview("Loading") {
    LoginView(state: .loading, interactor: LoginInteractorStub())
}

#Preview("Error") {
    LoginView(state: .error, interactor: LoginInteractorStub())
}

private final class LoginInteractorStub: LoginInteractor {
    func login() { }
    func loginToPolSocial() { }
}

extension LoginState {
    static var ready: LoginState { .init() }
    static var loading: LoginState { LoginState(isLoading: true) }
    static var error: LoginState { LoginState(error: "Some error message") }
}
