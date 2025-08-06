import SwiftUI

struct InstanceSelectingView: View {
    var state: InstanceSelectingState
    let interactor: InstanceSelectingInteractor
    
    var body: some View {
        ZStack {
            VStack {
                Text("Select mastodon instance from list or provide instance URL manually")
                    .font(.title3)
                    .fontWeight(.semibold)
                List(state.instances, id: \.self, selection: Bindable(state).selectedInstance) { instance in
                    Text(instance)
                }.onChange(of: state.selectedInstance, initial: false) {
                    interactor.selected(instance: state.selectedInstance)
                }
            }
            
            if let error = state.error {
                VStack {
                    Text(error)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                    Spacer()
                }
            }
        }
        .onAppear {
            interactor.start()
        }
    }
}

#Preview {
    InstanceSelectingView(state: InstanceSelectingState(), interactor: InstanceSelectingInteractorStub())
}

private final class InstanceSelectingInteractorStub: InstanceSelectingInteractor {
    func selected(instance: String?) { }
    func start() { }
}
