import SwiftUI

struct TimelineView: View {
    @State var state: TimelineState
    let interactor: TimelineInteractor
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(state.posts) { post in
                    TimelinePostView(post: post)
                        .onTapGesture {
                            interactor.selected(post: post)
                        }
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
    func selected(post: Post) { }
    func start() async { }
}
