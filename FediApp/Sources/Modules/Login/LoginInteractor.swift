import Foundation
import AuthenticationServices

protocol LoginInteractor {
    func login()
    func loginToPolSocial()
}

protocol LoginRouter: AnyObject {
    func loginCompleted()
}

private enum LoginError: Error {
    case invalidURLProvided
    case other(Error)
    
    var description: String {
        switch self {
            case .invalidURLProvided: return "Invalid URL provided"
            case .other(let error): return error.localizedDescription
        }
    }
}

final class DefaultLoginInteractor: LoginInteractor {
    var state: LoginState
    private weak var router: LoginRouter?
    private let loginService: LoginServing
    private let webPresentationContextProvider = WebAuthenticationContextProvider()
    
    init(state: LoginState, router: LoginRouter, loginService: LoginServing) {
        self.state = state
        self.router = router
        self.loginService = loginService
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
    
    //register app to url
    //log in with username and password via browser
    //obtain bearer token using code from browser
    
    private func login(to url: URL) async {
        await state.set(loading: true)
        do {
            let appCredentials = try await loginService.registerApp(to: url)
            let code = try await loginService.login(to: url, using: appCredentials.id, presentingOn: webPresentationContextProvider)
            print(code)
        } catch {
            await show(error: .other(error))
        }
        await state.set(loading: false)
    }
    
    private func show(error: LoginError) async {
        await state.set(error: error.description)
        try? await Task.sleep(for: .seconds(2))
        await state.clearError()
    }
}

class WebAuthenticationContextProvider: NSObject, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        ASPresentationAnchor()
    }
}
