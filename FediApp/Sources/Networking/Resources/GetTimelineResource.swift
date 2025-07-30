import Foundation

struct GetTimelineResource: Resource {
    typealias ResourceType = [PostDecodable]
    let httpRequestMethod: RequestMethod = .GET
    let path: String = "timelines/public"
    let body: Data? = nil
    let query: Parameters? = nil
    let isVersioned: Bool = true
}
