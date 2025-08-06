protocol TimelineServing {
    func fetchPublicTimeline() async throws -> [Post]
    func fetchLocalTimeline() async throws -> [Post]
}

final class TimelineService: TimelineServing {
    let networkClient: HostedNetworkClient	
    
    init(networkClient: HostedNetworkClient) {
        self.networkClient = networkClient
    }
    
    func fetchPublicTimeline() async throws -> [Post] {
        let resource = GetTimelineResource()
        let response = try await networkClient.request(resource: resource)
        return response.map(Post.init)
    }
    
    func fetchLocalTimeline() async throws -> [Post] {
        let resource = GetTimelineResource(local: true)
        let response = try await networkClient.request(resource: resource)
        return response.map(Post.init)
    }
}
