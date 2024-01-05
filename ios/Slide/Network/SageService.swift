
import GRPC

class SageService: NSObject, ObservableObject {
    var client: SageAsyncClient
    
    override init() {
        var group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        
        defer {
            try? group.shutdownGracefully()
        }
        
        self.client = SageAsyncClient(channel: try GRPCChannelPool.with(
            target: .host("10.0.0.40", port: 3000),
            transportSecurity: .plaintext,
            eventLoopGroup: group
        ))
    }
}
