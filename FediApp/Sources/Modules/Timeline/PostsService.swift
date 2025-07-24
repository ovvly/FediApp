protocol PostsServing {
    func fetchPosts() async throws -> [Post]
}

final class PostsService: PostsServing {
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func fetchPosts() async throws -> [Post] {
        let resource = GetTimelineResource()
        let response = try await networkClient.request(resource: resource)
        return response.map(Post.init)
    }
}
