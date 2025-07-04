import SwiftUI

struct TimelinePost: View {
    var body: some View {
        HStack {
            VStack {
                Image(systemName: "person.circle")
                Spacer()
            }
            VStack(alignment: .leading) {
                HStack {
                    Text("John Doe").bold()
                    Text("@johnDoe@masto.don")
                }
                Text("Some example message")
            }
        }
        .padding()
    }
}

#Preview {
    TimelinePost()
}
