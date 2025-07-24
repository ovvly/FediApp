protocol LoginInteractor {
    func login()
    func loginToPolSocial()
}

protocol LoginRouter: AnyObject {
}

final class DefaultLoginInteractor: LoginInteractor {
    var state: LoginState
    
    init(state: LoginState) {
        self.state = state
    }
    
    func login() {
        Task {
            let url = await state.serverUrl
            print("login to: \(url)")
        }
    }
    
    func loginToPolSocial() {
        print("login to pol social")
    }
}
