
import Foundation
import GRPC

class SageService: NSObject, ObservableObject {
    static let shared = SageService()
    
    let client = SageAsyncClient(
        channel: try! GRPCChannelPool.with(
            target: .host("10.0.0.40", port: 3000),
            transportSecurity: .plaintext,
            eventLoopGroup: PlatformSupport.makeEventLoopGroup(loopCount: 1)
        ),
        interceptors: SageServiceInterceptorFactory()
    )
}


