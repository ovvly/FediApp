import SwiftUI

@MainActor
final class ViewsFactory {
    let dependencies = Dependencies()
    
    @ViewBuilder
    func buildTimelineView(router: TimelineRouter) -> some View {
        let state = TimelineState()
        let service = dependencies.postsService
        let interactor = DefaultTimelineInteractor(state: state, router: router, postsService: service)
        
        TimelineView(state: state, interactor: interactor)
    }
    
    @ViewBuilder
    func buildPostDetails(post: Post) -> some View {
        Text(post.text)
    }
    
    @ViewBuilder
    func buildWelcomeScreen() -> some View {
        let interactor = DefaultWelcomeInteractor()
        WelcomeView(interactor: interactor)
    }
}
