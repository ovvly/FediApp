import Foundation
import AuthenticationServices

typealias Token = String

protocol LoginServing {
    func registerApp(to server: URL) async throws -> AppCredentials
    func login(to server: URL,
               using clientId: String,
               presentingOn presentiontContextProvider: ASWebAuthenticationPresentationContextProviding) async throws -> String
}

enum LoginServiceError: Error {
    case failedToBuildUrl
    case incorrectResponse
}

final class LoginService: LoginServing {
    private let networkClient: UnhostedNetworkClient
    private let authSessionBuilder: AuthSessionBuilder
    private var webAuthSession: WebAuthenticationSession?
    
    init(networkClient: UnhostedNetworkClient, authSessionBuilder: @escaping AuthSessionBuilder) {
        self.networkClient = networkClient
        self.authSessionBuilder = authSessionBuilder
    }
    
    func registerApp(to server: URL) async throws -> AppCredentials {
        let params = AppsParamsCodable(clinetName: "Fedi App", redirectUris: Constants.redirectURI, scopes: "read write push")
        let resource = try AppsResource(params: params)
        let response = try await networkClient.request(resource: resource, from: server)
        return AppCredentials(decodable: response)
    }
    
    func login(to server: URL,
               using clientId: String,
               presentingOn presentiontContextProvider: ASWebAuthenticationPresentationContextProviding) async throws -> String {
        let urlString = "\(server)/oauth/authorize?client_id=\(clientId)&scope=read+write+push&redirect_uri=\(Constants.redirectURI)&response_type=code"
        guard let url = URL(string: urlString) else { throw LoginServiceError.failedToBuildUrl }
        return try await withCheckedThrowingContinuation { continuation in
            webAuthSession = authSessionBuilder(url) { callbackURL, error in
                guard error == nil, let callbackURL = callbackURL else { return }
                let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
                if let code = queryItems?.filter({ $0.name == "code" }).first?.value {
                    continuation.resume(returning: code)
                } else {
                    continuation.resume(throwing: LoginServiceError.incorrectResponse)
                }
            }
            
            webAuthSession?.presentationContextProvider = presentiontContextProvider
            Task { @MainActor in
                webAuthSession?.start()
            }
        }
    }
    
    private struct Constants {
        static let redirectURI = "fediapp://oauth"
    }
}

typealias AuthSessionCompletionHandler = (URL?, (any Error)?) -> Void
typealias AuthSessionBuilder = (URL, @escaping AuthSessionCompletionHandler) -> WebAuthenticationSession

protocol WebAuthenticationSession: AnyObject {
    init(url: URL, callbackURLScheme: String?, completionHandler: @escaping AuthSessionCompletionHandler)
    func start() -> Bool
    
    var presentationContextProvider: ASWebAuthenticationPresentationContextProviding? { get set }
}

extension ASWebAuthenticationSession: WebAuthenticationSession { }
