protocol WelcomeInteractor {
    func logIn()
    func showFeeds()
}

final class DefaultWelcomeInteractor: WelcomeInteractor {
    func logIn() {
        print("log in")
    }
    
    func showFeeds() {
        print("show feeds")
    }
}
