import Foundation

extension Account {
    init(decodable: AccountDecodable) {
        let avatarUrl = URL(string: decodable.avatarUrl)
        self.init(id: decodable.id, username: decodable.accountName, displayName: decodable.displayName, avatar: avatarUrl)
    }
}
