import Foundation

struct GetTimelineResource: Resource {
    typealias ResourceType = [PostDecodable]
    let httpRequestMethod: RequestMethod = .GET
    let path: String = "timelines/public"
    let body: Data? = nil
    let query: Parameters?
    let apiVersion: Int? = 1
    
    init(local: Bool = false) {
        self.query = ["local": local ? "true" : "false"]
    }
}
