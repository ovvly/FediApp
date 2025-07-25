import Foundation
import SwiftUI

@MainActor @Observable
final class LoginState {
    var serverUrl: String = ""
    var error: String? = nil
    var isLoading = false
    
    init(serverUrl: String = "", error: String? = nil, isLoading: Bool = false) {
        self.serverUrl = serverUrl
        self.error = error
        self.isLoading = isLoading
    }
    
    func set(error: String) {
        self.error = error
    }
    
    func clearError() {
        error = nil
    }
    
    func set(loading: Bool) {
        isLoading = loading
        print(isLoading)
    }
}
