import SwiftUI

struct AppView: View {
    @State var appFlowController = AppFlowController()
    private var viewsFactory = ViewsFactory()
    
    var body: some View {
        viewsFactory.buildWelcomeScreen()
    }
}
