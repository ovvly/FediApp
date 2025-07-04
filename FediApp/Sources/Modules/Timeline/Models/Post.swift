import Foundation

struct Post: Identifiable {
    let id = UUID()
    
    var authorName: String
    var authorHandle: String
    var text: String
}
