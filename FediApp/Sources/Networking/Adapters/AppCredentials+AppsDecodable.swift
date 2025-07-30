extension AppCredentials {
    init(decodable: AppsDecodable) {        
        self.init(id: decodable.clientId, secret: decodable.clientSecret)
    }
}
