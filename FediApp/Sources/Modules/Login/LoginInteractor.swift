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
    private let accountServiceBuilder: (URL, String) -> AccountServing
    private let webPresentationContextProvider = WebAuthenticationContextProvider()
    
    init(state: LoginState, router: LoginRouter, loginService: LoginServing, accountServiceBuilder: @escaping (URL, String) -> AccountServing) {
        self.state = state
        self.router = router
        self.loginService = loginService
        self.accountServiceBuilder = accountServiceBuilder
    }
    
    func login() {
        Task {
            let url = await state.serverUrl
            guard let url = URL(string: url) else {
                await show(errorMessage: LoginError.invalidURLProvided.description)
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
        do {
            let appCredentials = try await loginService.registerApp(to: url)
            let code = try await loginService.login(to: url, using: appCredentials.id, presentingOn: webPresentationContextProvider)
            let token = try await loginService.obtainToken(from: url, clientId: appCredentials.id, clientSecret: appCredentials.secret, authCode: code)
            let accountService = accountServiceBuilder(url, token)
            let account = try await accountService.verifyCredentials()
            print(account)
        } catch NetworkingError.invalidStatusCode(_, let message) {
            await show(errorMessage: message)
        } catch {
            await show(errorMessage: error.localizedDescription)
        }
        await state.set(loading: false)
    }
    
    private func show(errorMessage: String) async {
        await state.set(error: errorMessage)
        try? await Task.sleep(for: .seconds(2))
        await state.clearError()
    }
}

class WebAuthenticationContextProvider: NSObject, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        ASPresentationAnchor()
    }
}
