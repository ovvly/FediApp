import SwiftUI

struct TimelineView: View {
    var state: TimelineState
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(state.posts) { post in
                    TimelinePost(post: post)
                }
            }
        }
    }
}

#Preview {
    TimelineView(state: TimelineState())
}
