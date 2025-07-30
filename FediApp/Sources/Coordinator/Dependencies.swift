import Foundation

final class Dependencies {
    var postsService: PostsServing {
        PostsService(networkClient: polSocialNetworkClient)
    }
    
    var loginService: LoginServing {
        LoginService(networkClient: unhostedNetworkClient)
    }
    
    private var unhostedNetworkClient: UnhostedNetworkClient {
        UnhostedNetworkClient()
    }
    
    private var polSocialNetworkClient: HostedNetworkClient {
        HostedNetworkClient(host: URL(string: "https://pol.social")!)
    }
}
