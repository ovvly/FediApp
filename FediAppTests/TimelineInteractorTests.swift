import Testing
@testable import FediApp

struct TimelineInteractorTests {

    @Test("When start is called it should return list of posts")
    func start() async throws {
        let state = await TimelineState()
        let sut = DefaultTimelineInteractor(state: state, router: TimelineRouterStub(), postsService: PostServiceStub())
        
        await sut.start()
        
        await #expect(state.posts.count == 3)
    }
    
    @Test("When post is selected it should pass it to action handler")
    func selectPost() async throws {
        let state = await TimelineState()
        let router = TimelineRouterStub()
        let sut = DefaultTimelineInteractor(state: state, router: router, postsService: PostServiceStub())
        
        sut.selected(post: Post.fixture)
        
        #expect(router.capturedPost?.authorName == Post.fixture.authorName)
        #expect(router.capturedPost?.authorHandle == Post.fixture.authorHandle)
        #expect(router.capturedPost?.text == Post.fixture.text)
    }
}

final class PostServiceStub: PostsServing {
    func fetchPosts() async throws -> [Post] {
        [Post.fixture,
         Post.fixture,
         Post.fixture]
    }
}

final class TimelineRouterStub: TimelineRouter {
    var capturedPost: Post? = nil
    func presentDetails(of post: Post) {
        capturedPost = post
    }
}

extension Post {
    static var fixture: Post {
        .init(authorName: "fake name", authorHandle: "fake handle", text: "fake text")
    }
}
