import Foundation

protocol InstanceServing {
    func fetchInstanceStatus(at url: URL) async throws -> InstanceStatus
}

final class InstanceService: InstanceServing {
    private let apiClient: UnhostedApiClient
    
    init(apiClient: UnhostedApiClient) {
        self.apiClient = apiClient
    }
    
    func fetchInstanceStatus(at url: URL) async throws -> InstanceStatus {
        let resource = InstanceStatusResource()
        let response = try await apiClient.request(resource: resource, from: url)
        return InstanceStatus(decodable: response)
    }
}

struct InstanceStatus {
    let domain: String
    let title: String
}

extension InstanceStatus {
    init(decodable: InstanceStatusDecodable) {
        self.init(domain: decodable.domain, title: decodable.title)
    }
}

struct InstanceStatusResource: Resource {
    typealias ResourceType = InstanceStatusDecodable
    let httpRequestMethod: RequestMethod = .GET
    let path: String = "instance"
    let body: Data? = nil
    let query: Parameters? = nil
    let apiVersion: Int? = 2
}

struct InstanceStatusDecodable: Decodable {
    let domain: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case domain = "domain"
        case title = "title"
    }
}
