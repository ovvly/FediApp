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
