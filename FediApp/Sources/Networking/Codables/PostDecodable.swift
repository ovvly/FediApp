struct PostDecodable: Decodable {
    let id: String
    let createdAt: String
    let content: String
    let repliesCount: Int
    let reblogsCount: Int
    let favouritesCount: Int
    let account: AccountDecodable
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case content
        case repliesCount = "replies_count"
        case reblogsCount = "reblogs_count"
        case favouritesCount = "favourites_count"
        case account
    }

    init(id: String, createdAt: String, content: String, repliesCount: Int, reblogsCount: Int, favouritesCount: Int, account: AccountDecodable) {
        self.id = id
        self.createdAt = createdAt
        self.content = content
        self.repliesCount = repliesCount
        self.reblogsCount = reblogsCount
        self.favouritesCount = favouritesCount
        self.account = account
    }
}
