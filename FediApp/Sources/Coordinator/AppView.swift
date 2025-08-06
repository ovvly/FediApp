import SwiftUI

struct AppView: View {
    @State var appFlowController = AppFlowController()
    private var viewsFactory = ViewsFactory()
    
    var body: some View {
        NavigationStack(path: $appFlowController.path) {
            viewsFactory.buildWelcomeScreen(router: appFlowController)
                .navigationDestination(for: WelcomeScreenDestination.self) { screen in
                    switch screen {
                    case .logIn:
                        viewsFactory.buidLogin(router: appFlowController)
                    case .feed:
                        viewsFactory.buildInstanceSelectingView(router: appFlowController)
                            .navigationDestination(for: InstanceSelectingDestination.self) { screen in
                                switch screen {
                                case .timeline(let instance):
                                    viewsFactory.buildTimelineView(instance: instance, router: appFlowController)
                                        .navigationDestination(for: TimelineScreenDestination.self) { screen in
                                            switch screen {
                                            case .details(let post):
                                                viewsFactory.buildPostDetails(post: post)
                                            }
                                        }

                                }
                            }
                    }
                }
        }
    }
}
