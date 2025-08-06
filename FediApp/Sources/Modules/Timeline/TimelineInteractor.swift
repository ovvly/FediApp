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
    private let timelineService: TimelineServing
    
    init(state: TimelineState, router: TimelineRouter, timelineService: TimelineServing) {
        self.state = state
        self.router = router
        self.timelineService = timelineService
    }
    
    func start() async {
        do {
            let newPosts = try await timelineService.fetchLocalTimeline()
            await state.update(posts: newPosts)
        } catch {
            print(error)
        }
    }
    
    func selected(post: Post) {
        router?.presentDetails(of: post)
    }
}
