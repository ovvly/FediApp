struct AppsParamsCodable: Codable {
    let clinetName: String
    let redirectUris: String
    let scopes: String
    
    private enum CodingKeys: String, CodingKey {
        case clinetName = "client_name"
        case redirectUris = "redirect_uris"
        case scopes = "scopes"
    }
}
