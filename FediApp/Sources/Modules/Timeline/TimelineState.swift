import Foundation

final class TimelineState: ObservableObject {
    let posts = [
        Post(authorName: "Lorem Ipsum", authorHandle: "@lorem@ipsum.com", text: "dolor sic"),
        Post(authorName: "John Mastodon", authorHandle: "@join.mastodon@masto.don", text: "hello"),
        Post(authorName: "Varroa Destructor", authorHandle: "@varoa@desctructor.com", text: "bla bla bla")
    ]
}
