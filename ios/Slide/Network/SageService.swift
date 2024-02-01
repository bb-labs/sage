
import Foundation
import GRPC
import Logging

class SageService: NSObject, ObservableObject {
    static let shared = SageService()

    var logger: Logger
    let client: SageAsyncClient

    
    override init () {
        self.logger = Logger(label: "gRPC", factory: StreamLogHandler.standardOutput(label:))
        self.logger.logLevel = .debug
        
        self.client = SageAsyncClient(
            channel: try! GRPCChannelPool.with(
                target: .host("10.0.0.40", port: 3000),
                transportSecurity: .plaintext,
                eventLoopGroup: PlatformSupport.makeEventLoopGroup(loopCount: 5)
            ),
            defaultCallOptions: CallOptions(logger: self.logger),
            interceptors: SageServiceInterceptorFactory()
        )
    }
}


