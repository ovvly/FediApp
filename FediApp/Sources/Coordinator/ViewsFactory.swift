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
}
