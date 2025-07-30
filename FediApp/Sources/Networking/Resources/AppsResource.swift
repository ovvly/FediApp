import Foundation

struct AppsResource: Resource {
    typealias ResourceType = AppsDecodable
    let httpRequestMethod: RequestMethod = .POST
    let path: String = "apps"
    let body: Data?
    let query: Parameters? = nil
    let isVersioned: Bool = true

    init(params: AppsParamsCodable) throws {
        let body = try JSONEncoder().encode(params)
        self.body = body
    }
}
