import Testing
@testable import FediApp

struct TimelineInteractorTests {

    @Test("When start is called then it should return list of posts")
    func start() async throws {
        let state = await TimelineState()
        let sut = DefaultTimelineInteractor(state: state, postsService: PostServiceStub())
        
        await sut.start()
        
        await #expect(state.posts.count == 3)
    }
}

final class PostServiceStub: PostsServing {
    func fetchPosts() async throws -> [Post] {
        [Post.fixture,
         Post.fixture,
         Post.fixture]
    }
}

extension Post {
    static var fixture: Post {
        .init(authorName: "fake name", authorHandle: "fake handle", text: "fake text")
    }
}
