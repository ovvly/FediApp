import AuthenticationServices

typealias AuthContextProviding = ASWebAuthenticationPresentationContextProviding

protocol AuthSessionHandler {
    func authenticate(url: URL, contextProvider: AuthContextProviding?) async throws -> URL
}

class ASWebAuthSessionHandler: AuthSessionHandler {
    private var webAuthSession: ASWebAuthenticationSession?
    
    func authenticate(url: URL, contextProvider: ASWebAuthenticationPresentationContextProviding?) async throws -> URL {
        return try await withCheckedThrowingContinuation { continuation in
            webAuthSession = ASWebAuthenticationSession(url: url, callbackURLScheme: "fediAppAuth") { callbackURL, error in
                if let error {
                    continuation.resume(throwing: LoginServiceError.other(error))
                    return
                }
                guard let callbackURL else {
                    continuation.resume(throwing:LoginServiceError.unknown)
                    return
                }
                
                continuation.resume(returning: callbackURL)
            }
            
            webAuthSession?.presentationContextProvider = contextProvider
            Task { @MainActor in
                webAuthSession?.start()
            }
        }
    }
}
