protocol TimelineInteractor {
    func start() async
}

final class DefaultTimelineInteractor: TimelineInteractor {
    private var state: TimelineState
    
    init(state: TimelineState) {
        self.state = state
    }
    
    func start() async {
        try? await Task.sleep(for: .seconds(1))
        let newPosts = [
            Post(authorName: "Lorem Ipsum", authorHandle: "@lorem@ipsum.com", text: "dolor sic"),
            Post(authorName: "John Mastodon", authorHandle: "@join.mastodon@masto.don", text: "hello"),
            Post(authorName: "Varroa Destructor", authorHandle: "@varoa@desctructor.com", text: "bla bla bla")
        ]
        await state.update(posts: newPosts)
    }
}
