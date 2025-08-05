protocol InstanceSelectingInteractor {
    func selected(instance: String?)
    func start()
}

protocol InstanceSelectingRouter: AnyObject {
    func selected(instance: String)
}

final class DefaultInstanceSelectingInteractor: InstanceSelectingInteractor {
    private var state: InstanceSelectingState
    private weak var router: InstanceSelectingRouter?
    
    init(state: InstanceSelectingState, router: InstanceSelectingRouter) {
        self.state = state
        self.router = router
    }
    
    func start() {
        Task { 
            await state.set(instances: ["mastodon.social", "pol.social", "mas.to", "mastodon.world", "mastodon.cloud", "mstdn.jp", "mstdn.social", "pixelfed.social"])
        }
    }
    
    func selected(instance: String?) {
        guard let instance else { return }
        router?.selected(instance: instance)
        Task {
            await state.setSelected(instance: nil)
        }
    }	
}
