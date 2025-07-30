import Foundation

typealias Token = String

protocol LoginServing {
    func registerApp(to server: URL) async throws -> AppCredentials
    func login(to server: URL,
               using clientId: String,
               presentingOn presentiontContextProvider: AuthContextProviding) async throws -> String
    func obtainToken(from server: URL, clientId: String, clientSecret: String, authCode: String) async throws -> String
}

enum LoginServiceError: Error {
    case failedToBuildUrl
    case incorrectResponse
    case unknown
    case other(Error)
}

final class LoginService: LoginServing {
    private let apiClient: UnhostedApiClient
    private let authSessionHandler: AuthSessionHandler
    
    init(apiClient: UnhostedApiClient, authSessionHandler: AuthSessionHandler) {
        self.apiClient = apiClient
        self.authSessionHandler = authSessionHandler
    }
    
    func registerApp(to server: URL) async throws -> AppCredentials {
        let params = AppsParamsCodable(clinetName: "Fedi App", redirectUris: Constants.redirectURI, scopes: "read write push")
        let resource = try AppsResource(params: params)
        let response = try await apiClient.request(resource: resource, from: server)
        return AppCredentials(decodable: response)
    }
    
    func login(to server: URL,
               using clientId: String,
               presentingOn presentiontContextProvider: AuthContextProviding) async throws -> String {
        guard let url = buildUrl(server: server, clientId: clientId) else { throw LoginServiceError.failedToBuildUrl }
        
        let responseUrl = try await authSessionHandler.authenticate(url: url, contextProvider: presentiontContextProvider)
        let queryItems = URLComponents(string: responseUrl.absoluteString)?.queryItems
        let codeQueryItem = queryItems?.first(where: { $0.name == "code" })
        guard let code = codeQueryItem?.value else { throw LoginServiceError.incorrectResponse }
        
        return code
    }
    
    func obtainToken(from server: URL, clientId: String, clientSecret: String, authCode: String) async throws -> String {
        let params = OAuthTokenParamsCodable(clientId: clientId, clientSecret: clientSecret, redirectUri: Constants.redirectURI, grantType: "client_credentials", code: authCode)
        let resource = try OAuthTokenResource(params: params)
        let response = try await apiClient.request(resource: resource, from: server)
        return response.accessToken
    }
    
    private func buildUrl(server: URL, clientId: String) -> URL? {
        guard var urlComponents = URLComponents(url: server, resolvingAgainstBaseURL: false) else { return nil }
        urlComponents.path.append("/oauth/authorize")
        urlComponents.queryItems = [URLQueryItem(name: "client_id", value: clientId),
                                    URLQueryItem(name: "scope", value: "read+write+push"),
                                    URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
                                    URLQueryItem(name: "response_type", value: "code")]
        return urlComponents.url

    }
    
    private struct Constants {
        static let redirectURI = "fediapp://oauth"
    }
}
