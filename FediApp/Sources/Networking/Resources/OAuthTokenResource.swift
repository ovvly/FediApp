import Foundation

struct OAuthTokenResource: Resource {
    typealias ResourceType = OAuthTokenDecodable
    let httpRequestMethod: RequestMethod = .POST
    let path = "oauth/token"
    let body: Data?
    let query: Parameters? = nil
    let isVersioned: Bool = false
    
    init(params: OAuthTokenParamsCodable) throws {
        let body = try JSONEncoder().encode(params)
        self.body = body
    }
}
