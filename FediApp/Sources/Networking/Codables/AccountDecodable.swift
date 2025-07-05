struct AccountDecodable: Decodable {
    let id: String
    let username: String
    let accountName: String
    let displayName: String
    let avatarUrl: String
    let followersCount: Int
    let followingCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case username
        case accountName = "acct"
        case displayName = "display_name"
        case avatarUrl = "avatar"
        case followersCount = "followers_count"
        case followingCount = "following_count"
    }

    init(id: String, username: String, accountName: String, displayName: String, avatarUrl: String, followersCount: Int, followingCount: Int) {
        self.id = id
        self.username = username
        self.accountName = accountName
        self.displayName = displayName
        self.avatarUrl = avatarUrl
        self.followersCount = followersCount
        self.followingCount = followingCount
    }
}
