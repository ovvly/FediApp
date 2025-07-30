import Foundation
@testable import FediApp

final class UnhostedApiClientSpy: UnhostedApiClient {
    var requestReturnValue: Any!
    
    func request<R: Resource>(resource: R, from host: URL) async throws -> R.ResourceType {
        return requestReturnValue as! R.ResourceType
    }
}
