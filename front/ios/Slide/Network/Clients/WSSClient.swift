
import Foundation
import SwiftProtobuf


class WSSClient: NSObject, URLSessionDelegate {
    var url = "ws://10.0.0.40:4000/session"
    public var socket: URLSessionWebSocketTask?
    public lazy var urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
    
    func start() {
        var urlComponents = URLComponents(string: self.url)!
        
        urlComponents.queryItems = []
        
        for credential in AuthModel.shared.credentials {
            urlComponents.queryItems! += credential.queryParams
        }
        
        self.socket = self.urlSession.webSocketTask(with: URLRequest(url: urlComponents.url!))
        self.socket?.resume()
    }
}

