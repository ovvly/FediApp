import Foundation

struct OAuthTokenResource: Resource {
    typealias ResourceType = OAuthTokenDecodable
    let httpRequestMethod: RequestMethod = .POST
    let path = "oauth/token"
    let body: Data? = nil
    let query: Parameters? = nil
    let isVersioned: Bool = false
}
