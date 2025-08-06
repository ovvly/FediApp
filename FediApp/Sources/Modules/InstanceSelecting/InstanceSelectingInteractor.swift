import Foundation

protocol InstanceSelectingInteractor {
    func selected(instance: String?)
    func start()
}

protocol InstanceSelectingRouter: AnyObject {
    func selected(instance: URL)
}

private enum InstanceSelectingError: Error {
    case invalidURLProvided
    case other(Error)
    
    var description: String {
        switch self {
            case .invalidURLProvided: return "Invalid URL provided"
            case .other(let error): return error.localizedDescription
        }
    }
}

final class DefaultInstanceSelectingInteractor: InstanceSelectingInteractor {
    private var state: InstanceSelectingState
    private let service: InstanceServing
    private weak var router: InstanceSelectingRouter?
    
    init(state: InstanceSelectingState, service: InstanceServing, router: InstanceSelectingRouter) {
        self.state = state
        self.service = service
        self.router = router
    }
    
    func start() {
        Task { 
            await state.set(instances: ["mastodon.social", "pol.social", "mas.to", "mastodon.world", "mastodon.cloud", "mstdn.jp", "mstdn.social", "pixelfed.social"])
        }
    }
    
    func selected(instance: String?) {
        guard let instance else { return }
        
        Task {
            guard let url = URL(string: "https://\(instance)") else { return }
            let instanceStatus = try await service.fetchInstanceStatus(at: url)
            print(instanceStatus)
            await state.setSelected(instance: nil)
            router?.selected(instance: url)
        }
    }
    
    private func show(errorMessage: String) async {
        await state.set(error: errorMessage)
        try? await Task.sleep(for: .seconds(2))
        await state.clearError()
    }
}
