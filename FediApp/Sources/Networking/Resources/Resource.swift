import Foundation

public protocol Resource {
    associatedtype ResourceType

    var path: String { get }
    var httpRequestMethod: RequestMethod { get }
    var body: Data? { get }
    var query: Parameters? { get }
    var isVersioned: Bool { get }
    func parse(_ data: Data, with parser: DataParser) throws -> ResourceType
}

public enum RequestMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}

public typealias Parameters = [String: Parameter?]

public protocol Parameter {
    var stringValue: String { get }
}
