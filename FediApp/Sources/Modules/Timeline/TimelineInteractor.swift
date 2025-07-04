protocol TimelineInteractor {
    func start() async
}

final class DefaultTimelineInteractor: TimelineInteractor {
    private var state: TimelineState
    private let postsService: PostsServing
    
    init(state: TimelineState, postsService: PostsServing) {
        self.state = state
        self.postsService = postsService
    }
    
    func start() async {
        do {
            let newPosts = try await postsService.fetchPosts()
            await state.update(posts: newPosts)
        } catch {
            print(error)
        }
    }
}

protocol PostsServing {
    func fetchPosts() async throws -> [Post]
}

final class PostsService: PostsServing {
    func fetchPosts() async throws -> [Post] {
        try? await Task.sleep(for: .seconds(1))
        return [
            Post(authorName: "Lorem Ipsum", authorHandle: "@lorem@ipsum.com", text: "dolor sic"),
            Post(authorName: "John Mastodon", authorHandle: "@join.mastodon@masto.don", text: "hello"),
            Post(authorName: "Varroa Destructor", authorHandle: "@varoa@desctructor.com", text: "bla bla bla")
        ]
    }
}
