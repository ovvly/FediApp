import Testing
import Foundation
import AuthenticationServices

@testable import FediApp

struct LoginServiceTests {
    @Test("when login is called it should pass correct url and context provider to session handler")
    func loginReturnUrl() async throws {
        let apiClientSpy = UnhostedApiClientSpy()
        let authSessionHandlerSpy = AuthSessionHandlerSpy()
        let sut = LoginService(apiClient: apiClientSpy, authSessionHandler: authSessionHandlerSpy)
        let authContextProvidingStub = await AuthContextProvidingStub()
        
        authSessionHandlerSpy.authenticateReturnValue = URL(string: "https://auth.return.value")!
        
        _ = try? await sut.login(to: URL(string: "https://fake.url.com")!, using: "fake_client_id", presentingOn: authContextProvidingStub)
        #expect(authSessionHandlerSpy.capturedUrl == URL(string: "https://fake.url.com/oauth/authorize?client_id=fake_client_id&scopes=read&redirect_uri=fediapp://oauth&response_type=code")!)
        #expect(authSessionHandlerSpy.capturedAuthContextProviding === authContextProvidingStub)
    }
    
    @Test("when login is called when code is correctly returned it should return correct code")
    func loginReturnCode() async throws {
        let apiClientSpy = UnhostedApiClientSpy()
        let authSessionHandlerSpy = AuthSessionHandlerSpy()
        let sut = LoginService(apiClient: apiClientSpy, authSessionHandler: authSessionHandlerSpy)
        let authContextProvidingStub = await AuthContextProvidingStub()
        
        authSessionHandlerSpy.authenticateReturnValue = URL(string: "https://auth.return.value?other_item=item&code=fake_code")!
        
        let code = try await sut.login(to: URL(string: "https://fake.url.com")!, using: "fake_client_id", presentingOn: authContextProvidingStub)
        #expect(code == "fake_code")
    }
    
    @Test("when login is called when response is incorrect it should return correct code")
    func loginResponseFail() async throws {
        let apiClientSpy = UnhostedApiClientSpy()
        let authSessionHandlerSpy = AuthSessionHandlerSpy()
        let sut = LoginService(apiClient: apiClientSpy, authSessionHandler: authSessionHandlerSpy)
        let authContextProvidingStub = await AuthContextProvidingStub()
        
        authSessionHandlerSpy.authenticateReturnValue = URL(string: "https://auth.return.value")!
        
        await #expect(throws: LoginServiceError.incorrectResponse) {
            _ = try await sut.login(to: URL(string: "https://fake.url.com")!, using: "fake_client_id", presentingOn: authContextProvidingStub)
        }
    }
}

private final class AuthContextProvidingStub: NSObject, AuthContextProviding {
    var capturedSession: ASWebAuthenticationSession! = nil
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        capturedSession = session
        
        return UIWindow()
    }
}

extension LoginServiceError: @retroactive Equatable {
    public static func == (lhs: LoginServiceError, rhs: LoginServiceError) -> Bool {
        switch (lhs, rhs) {
        case (.failedToBuildUrl, .failedToBuildUrl):
            return true
        case (.incorrectResponse, .incorrectResponse):
            return true
        case (.unknown, .unknown):
            return true
        case (.other, .other):
            return true
        default:
            return false
        }
    }
}
