import Foundation

enum NetworkingError: Error {
    case failedToBuildRequest
    case requestPayloadParsingError(Error?)
    case invalidResponse
    case invalidStatusCode(httpCode: Int)
    case parsingError(description: String)
}

final class HostedNetworkClient {
    private let unhostedClient: UnhostedNetworkClient
    private let host: URL
    
    init(with networkSession: NetworkSession = URLSession.shared, host: URL) {
        self.unhostedClient = UnhostedNetworkClient(with: networkSession)
        self.host = host
    }
    
    func request<R: Resource>(resource: R, with decoder: DataParser = JSONDecoder()) async throws -> R.ResourceType {
        try await unhostedClient.request(resource: resource, from: host, with: decoder)
    }
}

final class UnhostedNetworkClient {
    private let networkSession: NetworkSession
    private let apiVersion = "/api/v1"

    init(with networkSession: NetworkSession = URLSession.shared) {
        self.networkSession = networkSession
    }

    func request<R: Resource>(resource: R, from host: URL, with decoder: DataParser = JSONDecoder()) async throws -> R.ResourceType {
        let request = try buildUrlRequest(for: resource, host: host)
        let (data, urlResponse) = try await networkSession.data(for: request)
        guard let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode else {
            throw NetworkingError.invalidResponse
        }
        guard 200 ..< 300 ~= statusCode else {
            print(statusCode)
            throw NetworkingError.invalidStatusCode(httpCode: statusCode)
        }
        return try resource.parse(data, with: decoder)
    }

    private func buildUrlRequest<R: Resource>(for resource: R, host: URL) throws -> URLRequest {
        guard let requestURL = resource.buildUrl(host: host, apiVersion: apiVersion) else {
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

    func buildUrl(host: URL, apiVersion: String) -> URL? {
        guard var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: false) else { return nil }
        if isVersioned {
            urlComponents.path.append(apiVersion)
        }
        urlComponents.path.append("/\(path)")
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}
