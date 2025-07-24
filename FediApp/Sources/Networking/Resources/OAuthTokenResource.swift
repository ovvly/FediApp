import Foundation

struct OAuthTokenResource: Resource {
    typealias ResourceType = OAuthTokenDecodable
    let httpRequestMethod: RequestMethod
    let path: String
    let body: Data? = nil
    let query: Parameters? = nil
    let isVersioned: Bool = false

    public init() {
        httpRequestMethod = .POST
        path = "oauth/token"
    }
}
