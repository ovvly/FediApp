import Foundation

struct AppsResource: Resource {
    typealias ResourceType = AppsDecodable
    let httpRequestMethod: RequestMethod
    let path: String
    let body: Data? = nil
    let query: Parameters? = nil
    let isVersioned: Bool = true

    public init() {
        httpRequestMethod = .POST
        path = "apps"
    }
}
