import Foundation

enum NetworkingError: Error {
    case failedToBuildRequest
    case requestPayloadParsingError(Error?)
    case invalidResponse
    case invalidStatusCode(httpCode: Int)
    case parsingError(description: String)
}

final class NetworkClient {
    private let networkSession: NetworkSession
    private let host: String

    init(with networkSession: NetworkSession = URLSession.shared, host: String) {
        self.networkSession = networkSession
        self.host = host
    }

    func request<R: Resource>(resource: R) async throws -> R.ResourceType {
        let decoder = JSONDecoder()
        return try await request(resource: resource, with: decoder)
    }

    func request<R: Resource>(resource: R, with decoder: DataParser) async throws -> R.ResourceType {
        let request = try buildUrlRequest(for: resource)
        let (data, urlResponse) = try await networkSession.data(for: request)
        guard let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode else {
            throw NetworkingError.invalidResponse
        }
        guard 200 ..< 300 ~= statusCode else {
            throw NetworkingError.invalidStatusCode(httpCode: statusCode)
        }
        return try resource.parse(data, with: decoder)
    }

    private func buildUrlRequest<R: Resource>(for resource: R) throws -> URLRequest {
        guard let requestURL = resource.buildUrl(host: host) else {
            throw NetworkingError.failedToBuildRequest
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = resource.httpRequestMethod.rawValue
        request.httpBody = resource.body
        if resource.body != nil {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
}

private extension Resource {
    var queryItems: [URLQueryItem]? {
        query?.compactMap { key, value in
            URLQueryItem(name: key, value: value?.stringValue)
        }
    }

    func buildUrl(host: String) -> URL? {
        guard var urlComponents = URLComponents(string: host) else { return nil }
        urlComponents.path.append("/\(path)")
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}
