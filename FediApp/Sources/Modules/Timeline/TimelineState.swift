import Foundation

@MainActor @Observable
final class TimelineState {
    var posts: [Post] = []
    
    func update(posts: [Post]) {
        self.posts = posts
    }
}
