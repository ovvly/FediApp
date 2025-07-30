import Foundation
import AuthenticationServices

final class Dependencies {
    var postsService: PostsServing {
        PostsService(networkClient: polSocialNetworkClient)
    }
    
    var loginService: LoginServing {
        let sessionHandler = ASWebAuthSessionHandler()
        return LoginService(networkClient: unhostedNetworkClient, authSessionHandler: sessionHandler)
    }
    
    private var unhostedNetworkClient: UnhostedNetworkClient {
        UnhostedNetworkClient()
    }
    
    private var polSocialNetworkClient: HostedNetworkClient {
        HostedNetworkClient(host: URL(string: "https://pol.social")!)
    }
}
