import SwiftUI

struct TimelinePost: View {
    let post: Post
    
    var body: some View {
        HStack {
            VStack {
                Image(systemName: "person.circle")
                Spacer()
            }
            VStack(alignment: .leading) {
                HStack {
                    Text(post.authorName)
                        .bold()
                        .lineLimit(1)
                    Text(post.authorHandle)
                        .font(.caption)
                        .lineLimit(1)
                }
                Text(post.text)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    VStack {
        TimelinePost(post: Post.stub)
    }
}

private extension Post {
    static var stub: Post {
        .init(
            authorName: "John Doe",
            authorHandle: "@johndoe",
            text: "Hello, world!"
        )
    }
}
