import SwiftUI

enum Screen: Identifiable, Hashable {
    case details(Post)
    
    var id: Self { return self }
}

@Observable
final class AppFlowController {
    var path = NavigationPath()
}

extension AppFlowController: TimelineRouter {
    func presentDetails(of post: Post) {
        path.append(Screen.details(post))
    }
}
