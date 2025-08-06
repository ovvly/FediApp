import SwiftUI

enum WelcomeScreenDestination: SelfIdentifiable {
    case logIn
    case feed
}

enum TimelineScreenDestination: SelfIdentifiable {
    case details(Post)
}

enum InstanceSelectingDestination: SelfIdentifiable {
    case timeline(URL)
}

@Observable
final class AppFlowController {
    var path = NavigationPath()
}

extension AppFlowController: WelcomeRouter {
    func presentFeed() {
        path.append(WelcomeScreenDestination.feed)
    }
    
    func presentLogin() {
        path.append(WelcomeScreenDestination.logIn)
    }
}

extension AppFlowController: TimelineRouter {
    func presentDetails(of post: Post) {
        path.append(TimelineScreenDestination.details(post))
    }
}

extension AppFlowController: LoginRouter {
    func loginCompleted() {
        path.removeLast()
        path.append(WelcomeScreenDestination.feed)
    }
}

extension AppFlowController: InstanceSelectingRouter {
    func selected(instance: URL) {
        path.append(InstanceSelectingDestination.timeline(instance))
    }
}
