import Foundation

struct VerifyCredentialsResource: Resource {
    typealias ResourceType = AccountDecodable
    let httpRequestMethod: RequestMethod = .GET
    let path: String = "accounts/verify_credentials"
    let body: Data? = nil
    let query: Parameters? = nil
    let isVersioned: Bool = true
}
