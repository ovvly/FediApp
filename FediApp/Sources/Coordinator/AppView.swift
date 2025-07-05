import SwiftUI

struct AppView: View {
    @State var appFlowController = AppFlowController()
    private var viewsFactory = ViewsFactory()
    
    var body: some View {
        NavigationStack(path: $appFlowController.path) {
            viewsFactory.buildTimelineView(router: appFlowController)
                .navigationDestination(for: Screen.self) { screen in
                    switch screen {
                    case .details(let post):
                        viewsFactory.buildPostDetails(post: post)
                    }
                }
        }
    }
}

@MainActor
final class ViewsFactory {
    @ViewBuilder
    func buildTimelineView(router: TimelineRouter) -> some View {
        let state = TimelineState()
        let interactor = DefaultTimelineInteractor(state: state, router: router, postsService: PostsService())
        
        TimelineView(state: state, interactor: interactor)
    }
    
    @ViewBuilder
    func buildPostDetails(post: Post) -> some View {
        Text(post.text)
    }
}
