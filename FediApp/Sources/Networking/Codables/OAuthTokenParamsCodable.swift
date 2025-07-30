import Foundation

struct OAuthTokenParamsCodable: Codable {
    let clientId: String
    let clientSecret: String
    let redirectUri: String
    let grantType: String
    let code: String
    
    enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
        case clientSecret = "client_secret"
        case redirectUri = "redirect_uri"
        case grantType = "grant_type"
        case code = "code"
    }
}
