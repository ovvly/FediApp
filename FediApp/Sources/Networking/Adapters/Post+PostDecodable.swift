extension Post {
    init(decodable: PostDecodable) {
        let authorName = decodable.account.displayName
        let authorHandle = decodable.account.accountName
        let text = decodable.content
        
        self.init(authorName: authorName, authorHandle: authorHandle, text: text)
    }
}
