import Foundation

extension URLSession: NetworkSession {
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await data(for: request, delegate: nil)
    }
}

extension Resource where ResourceType: Decodable {
    func parse(_ data: Data, with parser: DataParser) throws -> ResourceType {
        try parser.decode(ResourceType.self, from: data)
    }
}

extension Resource where ResourceType == Void {
    func parse(_ data: Data, with parser: DataParser) throws -> ResourceType { () }
}

extension JSONDecoder: DataParser { }
