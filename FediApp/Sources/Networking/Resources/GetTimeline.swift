import Foundation

struct GetTimeline: Resource {
    typealias ResourceType = [PostDecodable]
    let httpRequestMethod: RequestMethod
    let path: String
    let body: Data? = nil
    let query: Parameters? = nil

    public init() {
        httpRequestMethod = .GET
        path = "timelines/public"
    }
}
