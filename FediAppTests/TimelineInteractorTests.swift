import Testing
@testable import FediApp

struct TimelineInteractorTests {

    @Test("When start is called then it should return list of posts")
    func start() async throws {
        let state = await TimelineState()
        let sut = DefaultTimelineInteractor(state: state)
        
        await sut.start()
        
        await #expect(state.posts.count == 3)
    }
}
