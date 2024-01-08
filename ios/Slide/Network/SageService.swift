
import Foundation
import GRPC

class SageService: NSObject, ObservableObject {
    static let shared = SageService()
    
    let client = SageAsyncClient(
        channel: try! GRPCChannelPool.with(
            target: .host("sage.dating"),
            transportSecurity: .tls(.makeClientConfigurationBackedByNIOSSL()),
            eventLoopGroup: PlatformSupport.makeEventLoopGroup(loopCount: 1)
        ),
        interceptors: SageServiceInterceptorFactory()
    )
}


