final class Dependencies {
    var postsService: PostsService {
        PostsService(networkClient: networkClient)
    }
    
    private var networkClient: NetworkClient {
        NetworkClient(host: "https://pol.social", apiVersion: "/api/v1")
    }
}
