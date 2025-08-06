import Foundation
import SwiftUI

@MainActor @Observable
final class InstanceSelectingState {
    var instances: [String] = []
    var selectedInstance: String? = nil
    var error: String? = nil

    
    func set(instances: [String]) {
        self.instances = instances
    }
    
    func setSelected(instance: String?) {
        selectedInstance = instance
    }
    
    func set(error: String) {
        self.error = error
    }
    
    func clearError() {
        error = nil
    }
}
