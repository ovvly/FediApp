import Foundation
@testable import FediApp

final class AuthSessionHandlerSpy: AuthSessionHandler {
    var capturedUrl: URL? = nil
    var capturedAuthContextProviding: AuthContextProviding? = nil
    var authenticateReturnValue: URL! = nil
    
    func authenticate(url: URL, contextProvider: AuthContextProviding?) async throws -> URL {
        capturedUrl = url
        capturedAuthContextProviding = contextProvider
        return authenticateReturnValue
    }
}
