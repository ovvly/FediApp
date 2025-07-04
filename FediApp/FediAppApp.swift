import SwiftUI

@main
struct FediAppApp: App {
    var body: some Scene {
        WindowGroup {
            let state = TimelineState()
            let interactor = DefaultTimelineInteractor(state: state)
            TimelineView(state: state, interactor: interactor)
        }
    }
}
