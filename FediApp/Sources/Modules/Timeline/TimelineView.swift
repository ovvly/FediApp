import SwiftUI

struct TimelineView: View {
    @State var state: TimelineState
    var interactor: TimelineInteractor
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(state.posts) { post in
                    TimelinePost(post: post)
                }
            }
        }
        .task {
            await interactor.start()
        }
    }
}

#Preview {
    TimelineView(state: TimelineState(), interactor: TimelineInteractorStub())
}

final class TimelineInteractorStub: TimelineInteractor {
     func start() async {
        
    }
}
