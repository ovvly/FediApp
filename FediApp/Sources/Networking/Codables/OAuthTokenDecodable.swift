struct OAuthTokenDecodable: Decodable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }

    init(accessToken: String) {
        self.accessToken = accessToken
    }
}
