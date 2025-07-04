import SwiftUI

@main
struct FediAppApp: App {
    var body: some Scene {
        WindowGroup {
            let state = TimelineState()
            let interactor = DefaultTimelineInteractor(state: state, postsService: PostsService())
            TimelineView(state: state, interactor: interactor)
        }
    }
}
