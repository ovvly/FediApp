protocol WelcomeInteractor {
    func logIn()
    func showFeeds()
}

protocol WelcomeRouter: AnyObject {
    func presentFeed()
    func presentLogin()
}

final class DefaultWelcomeInteractor: WelcomeInteractor {
    private weak var router: WelcomeRouter?

    init(router: WelcomeRouter) {
        self.router = router
    }
    
    func logIn() {
        router?.presentLogin()
    }
    
    func showFeeds() {
        router?.presentFeed()
    }
}
