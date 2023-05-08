
import Foundation
import WebRTC

final class WebRTCSignalingClient: NSObject, URLSessionDelegate {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private var socket: URLSessionWebSocketTask?
    private lazy var urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
    
    init(url: URL) {
        super.init()
        
        self.socket = urlSession.webSocketTask(with: url)
        self.socket?.resume()
    }
    
    
    func send(sdp rtcSdp: RTCSessionDescription) {
        let message = Message.sdp(SessionDescription(from: rtcSdp))
        do {
            let dataMessage = try self.encoder.encode(message)
            
            self.socket?.send(.data(dataMessage)) { _ in }
        }
        catch {
            debugPrint("Warning: Could not encode sdp: \(error)")
        }
    }
    
    func send(candidate rtcIceCandidate: RTCIceCandidate) {
        let message = Message.candidate(IceCandidate(from: rtcIceCandidate))
        do {
            let dataMessage = try self.encoder.encode(message)
            self.socket?.send(.data(dataMessage)) { _ in }
        }
        catch {
            debugPrint("Warning: Could not encode candidate: \(error)")
        }
    }
    
    func receive(candidate rtcIceCandidate: RTCIceCandidate) {
        self.socket?.receive { result in
            switch result {
            case .success(let message):
                switch message {
                case .data(let data):
                    let message: Message
                    do {
                        message = try self.decoder.decode(Message.self, from: data)
                    }
                    catch {
                        debugPrint("Warning: Could not decode incoming message: \(error)")
                        return
                    }
                    
                    switch message {
                    case .candidate(let iceCandidate):
                        print("Ice: ", iceCandidate)
                    case .sdp(let sessionDescription):
                        print("Sdp: ", sessionDescription)
                    }
                    
                case .string(let string):
                    print("should have strings", string)
                @unknown default:
                    print("Unknown whoa")
                }
            case .failure:
                print("Failed!")
            }
        }
    }
}


