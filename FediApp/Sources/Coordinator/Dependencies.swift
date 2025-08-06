import Foundation
import AuthenticationServices

final class Dependencies {
    var instanceService: InstanceServing {
        InstanceService(apiClient: unhostedNetworkClient)
    }
    
    var loginService: LoginServing {
        let sessionHandler = ASWebAuthSessionHandler()
        return LoginService(apiClient: unhostedNetworkClient, authSessionHandler: sessionHandler)
    }
    
    func timelineService(instance: URL) -> TimelineServing {
        let client = HostedNetworkClient(host: instance)
        return TimelineService(networkClient: client)
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
