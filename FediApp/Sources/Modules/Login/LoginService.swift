import Foundation

typealias Token = String

protocol LoginServing {
    func registerApp(to server: URL) async throws -> AppCredentials
    func login(to server: URL,
               using clientId: String,
               presentingOn presentiontContextProvider: AuthContextProviding) async throws -> String
}

enum LoginServiceError: Error {
    case failedToBuildUrl
    case incorrectResponse
    case unknown
    case other(Error)
}

final class LoginService: LoginServing {
    private let networkClient: UnhostedNetworkClient
    private let authSessionHandler: AuthSessionHandler
    
    init(networkClient: UnhostedNetworkClient, authSessionHandler: AuthSessionHandler) {
        self.networkClient = networkClient
        self.authSessionHandler = authSessionHandler
    }
    
    func registerApp(to server: URL) async throws -> AppCredentials {
        let params = AppsParamsCodable(clinetName: "Fedi App", redirectUris: Constants.redirectURI, scopes: "read write push")
        let resource = try AppsResource(params: params)
        let response = try await networkClient.request(resource: resource, from: server)
        return AppCredentials(decodable: response)
    }
    
    func login(to server: URL,
               using clientId: String,
               presentingOn presentiontContextProvider: AuthContextProviding) async throws -> String {
        let urlString = "\(server)/oauth/authorize?client_id=\(clientId)&scope=read+write+push&redirect_uri=\(Constants.redirectURI)&response_type=code"
        guard let url = URL(string: urlString) else { throw LoginServiceError.failedToBuildUrl }
        
        let responseUrl = try await authSessionHandler.authenticate(url: url, contextProvider: presentiontContextProvider)
        let queryItems = URLComponents(string: responseUrl.absoluteString)?.queryItems
        if let code = queryItems?.filter({ $0.name == "code" }).first?.value {
            return code
        } else {
            throw LoginServiceError.incorrectResponse
        }
    }
    
    private struct Constants {
        static let redirectURI = "fediapp://oauth"
    }
}
