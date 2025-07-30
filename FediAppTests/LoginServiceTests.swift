import Testing
import Foundation

@testable import FediApp

struct LoginServiceTests {
    @Test("when login is called it should build correct url")
    func loginReturnUrl() {
        #expect(true)
    }
    
    @Test("when login is called when code is correctly returned it should return correct code")
    func loginReturnCode() {
        
    }
    
    @Test("when login is called when response is incorrect it should return correct code")
    func loginResponseFail() {
        
    }
}

private final class WebAuthenticationSessionSpy: WebAuthenticationSession {
    convenience init(url: URL, callbackURLScheme: String?, completionHandler: @escaping CompletionHandler) {
        self.init()
    }
}
