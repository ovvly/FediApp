import Foundation

struct GetTimelineResource: Resource {
    typealias ResourceType = [PostDecodable]
    let httpRequestMethod: RequestMethod
    let path: String
    let body: Data? = nil
    let query: Parameters? = nil
    let isVersioned: Bool = false

    public init() {
        httpRequestMethod = .GET
        path = "timelines/public"
    }
}
