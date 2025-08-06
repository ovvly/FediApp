import SwiftUI

@MainActor
final class ViewsFactory {
    let dependencies = Dependencies()
    
    @ViewBuilder
    func buildWelcomeScreen(router: WelcomeRouter) -> some View {
        let interactor = DefaultWelcomeInteractor(router: router)
        WelcomeView(interactor: interactor)
    }
    
    @ViewBuilder
    func buidLogin(router: LoginRouter) -> some View {
        let state = LoginState()
        let loginService = dependencies.loginService
        let accountServiceBuilder = { [dependencies] host, token in
            dependencies.accountService(host: host, token: token)
        }
        let interactor = DefaultLoginInteractor(state: state, router: router, loginService: loginService, accountServiceBuilder: accountServiceBuilder)
        LoginView(state: state, interactor: interactor)
    }
    
    @ViewBuilder
    func buildTimelineView(instance: URL, router: TimelineRouter) -> some View {
        let state = TimelineState()
        let service = dependencies.timelineService(instance: instance)
        let interactor = DefaultTimelineInteractor(state: state, router: router, timelineService: service)
        
        TimelineView(state: state, interactor: interactor)
    }
    
    @ViewBuilder
    func buildInstanceSelectingView(router: InstanceSelectingRouter) -> some View {
        let state = InstanceSelectingState()
        let instanceService = dependencies.instanceService
        let interactor = DefaultInstanceSelectingInteractor(state: state, service: instanceService, router: router)
        InstanceSelectingView(state: state, interactor: interactor)
    }
    
    @ViewBuilder
    func buildPostDetails(post: Post) -> some View {
        Text(post.text)
    }
}
