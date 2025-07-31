import Foundation
import AuthenticationServices

final class Dependencies {
    var postsService: PostsServing {
        PostsService(networkClient: polSocialNetworkClient)
    }
    
    var loginService: LoginServing {
        let sessionHandler = ASWebAuthSessionHandler()
        return LoginService(apiClient: unhostedNetworkClient, authSessionHandler: sessionHandler)
    }
    
    func accountService(host: URL, token: String) -> AccountServing {
        let client = HostedNetworkClient(host: host)
        client.token = token
        return AccountService(apiClient: client)
    }
    
    private var unhostedNetworkClient: UnhostedNetworkClient {
        UnhostedNetworkClient()
    }
    
    private var polSocialNetworkClient: HostedNetworkClient {
        HostedNetworkClient(host: URL(string: "https://pol.social")!)
    }
}
