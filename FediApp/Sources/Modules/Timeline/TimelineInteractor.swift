protocol TimelineInteractor {
    func start() async
    func selected(post: Post)
}

protocol TimelineRouter: AnyObject {
    func presentDetails(of post: Post)
}

final class DefaultTimelineInteractor: TimelineInteractor {
    private var state: TimelineState
    private weak var router: TimelineRouter?
    private let postsService: PostsServing
    
    init(state: TimelineState, router: TimelineRouter, postsService: PostsServing) {
        self.state = state
        self.router = router
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
    
    func selected(post: Post) {
        router?.presentDetails(of: post)
    }
}
