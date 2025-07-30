import Foundation
import AuthenticationServices

final class Dependencies {
    var postsService: PostsServing {
        PostsService(networkClient: polSocialNetworkClient)
    }
    
    var loginService: LoginServing {
        LoginService(networkClient: unhostedNetworkClient, authSessionBuilder: { url, completionHandler in
            ASWebAuthenticationSession(url: url, callbackURLScheme: "fediAppAuth", completionHandler: completionHandler)
        })
    }
    
    private var unhostedNetworkClient: UnhostedNetworkClient {
        UnhostedNetworkClient()
    }
    
    private var polSocialNetworkClient: HostedNetworkClient {
        HostedNetworkClient(host: URL(string: "https://pol.social")!)
    }
}
