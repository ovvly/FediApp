protocol AccountServing {
    func verifyCredentials() async throws -> Account
}

final class AccountService: AccountServing {
    private let apiClient: HostedNetworkClient
    
    init(apiClient: HostedNetworkClient) {
        self.apiClient = apiClient
    }
    
    func verifyCredentials() async throws -> Account {
        let resource = VerifyCredentialsResource()
        let response = try await apiClient.request(resource: resource)
        return Account(decodable: response)
    }
}
