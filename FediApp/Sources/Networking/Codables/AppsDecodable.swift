struct AppsDecodable: Decodable {
    let clientId: String
    let clientSecret: String
    let clientSecretExpiration: Int
    
    enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
        case clientSecret = "client_secret"
        case clientSecretExpiration = "client_secret_expires_at"
    }

    init(clientId: String, clientSecret: String, clientSecretExpiration: Int) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.clientSecretExpiration = clientSecretExpiration
    }
}
