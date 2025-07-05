import Foundation

struct Post: Identifiable, Hashable {
    let id = UUID()
    
    var authorName: String
    var authorHandle: String
    var text: String
}
