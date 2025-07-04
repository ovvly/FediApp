import SwiftUI

struct TimelineView: View {
    let posts = [
        Post(authorName: "Lorem Ipsum", authorHandle: "@lorem@ipsum.com", text: "dolor sic"),
        Post(authorName: "John Mastodon", authorHandle: "@join.mastodon@masto.don", text: "hello"),
        Post(authorName: "Varroa Destructor", authorHandle: "@varoa@desctructor.com", text: "bla bla bla")
    ]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(posts) { post in
                    TimelinePost(post: post)
                }
            }
        }
    }
}

#Preview {
    TimelineView()
}
