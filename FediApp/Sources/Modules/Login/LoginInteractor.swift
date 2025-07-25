import Foundation

protocol LoginInteractor {
    func login()
    func loginToPolSocial()
}

protocol LoginRouter: AnyObject {
}

private enum LoginError: Error {
    case invalidURLProvided
    
    var description: String {
        switch self {
            case .invalidURLProvided: return "Invalid URL provided"
        }
    }
}

final class DefaultLoginInteractor: LoginInteractor {
    var state: LoginState
    
    init(state: LoginState) {
        self.state = state
    }
    
    func login() {
        Task {
            let url = await state.serverUrl
            guard let url = URL(string: url) else {
                await show(error: .invalidURLProvided)
                return
            }
            await login(to: url)
        }
    }
    
    func loginToPolSocial() {
        guard let url = URL(string: "https://pol.social") else { return }
        Task {
            await login(to: url)
        }
    }
    
    private func login(to url: URL) async {
        await state.set(loading: true)
    }
    
    private func show(error: LoginError) async {
        await state.set(error: error.description)
        try? await Task.sleep(for: .seconds(2))
        await state.clearError()
    }
}
