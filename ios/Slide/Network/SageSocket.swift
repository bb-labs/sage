
import Foundation
import SwiftProtobuf


class WSSClient: NSObject, URLSessionDelegate {
    public var socket: URLSessionWebSocketTask?
    public lazy var urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
    
    override init () {
        super.init()
        
        self.socket = self.urlSession.webSocketTask(
            with: URLRequest(url: URLComponents(string: "ws://10.0.0.40:3001/connect")!.url!)
        )
        
        self.socket?.resume()
    }
}
