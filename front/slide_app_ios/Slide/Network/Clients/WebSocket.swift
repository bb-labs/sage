 
import Foundation

class NativeWebSocket: NSObject, URLSessionWebSocketDelegate {
    private var socket: URLSessionWebSocketTask?
    private lazy var urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())

    init(url: URL) {
        super.init()
        
        self.socket = urlSession.webSocketTask(with: url)
        self.socket?.resume()
    }

    func send(data: Data) {
        self.socket?.send(.data(data)) { _ in }
    }
    
    func read() {
        self.socket?.receive { result in
            switch result {
            case .success(let message):
                print(message)
            case .failure:
                self.disconnect()
            }
        }
    }
    
    private func disconnect() {
        self.socket?.cancel()
    }
}

