import Foundation

struct Post: Identifiable, Hashable {
    let id = UUID()
    
    var authorName: String
    var authorHandle: String
    var text: String
}

extension Post {
    var attributedText: AttributedString? {
        let data = Data(text.utf8)
        guard let nsAttributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else { return nil }
        return try? AttributedString(nsAttributedString, including: \.uiKit)
    }
}
