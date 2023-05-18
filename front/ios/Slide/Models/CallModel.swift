

import Foundation
import CallKit

class CallModel: NSObject, CXProviderDelegate {
    let provider = CXProvider(configuration: CXProviderConfiguration())
    let controller = CXCallController()
    
    func providerDidReset(_ provider: CXProvider) {
        
    }
    
}
