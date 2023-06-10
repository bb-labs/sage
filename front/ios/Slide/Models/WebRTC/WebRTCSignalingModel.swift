

import Foundation
import WebRTC

extension WebRTCModel {
    func listen() {
        self.socket?.receive { message in
            switch message {
            case .success(.data(let data)):
                do {
                    let request = try WebRTCSignalingRequest(serializedData: data)
                    
                    switch request.type {
                    case .sdp:
                        let sdp = RTCSessionDescription(
                            type: RTCSdpType(rawValue: Int(request.sdpType))!,
                            sdp: request.sdp
                        )
                        
                        self.peerConnection.setRemoteDescription(sdp) { err in
                            if let err = err { debugPrint(err.localizedDescription) }
                        }
                        
                        debugPrint("Got sdp from : \(request.user.name)")
                    case .ice:
                        let candidate = RTCIceCandidate(
                            sdp: request.sdp,
                            sdpMLineIndex: request.iceLineIndex,
                            sdpMid: request.iceStreamID
                        )
                        
                        self.peerConnection.add(candidate) { err in
                            if let err = err { debugPrint(err.localizedDescription) }
                        }
                    case .UNRECOGNIZED(_):
                        debugPrint("Unexpected data format for signaling data")
                    }
                }
                catch {
                    debugPrint("Failed to parse signaling data")
                }
            case .success:
                debugPrint("Warning: Expected to receive data format. Check the websocket server config.")
            case .failure:
                debugPrint("Failed to recieve data")
            }
        }
    }
    
    enum Direction {
        case offer, answer
    }
    
    private func connect(from srcUser: User, to dstUser: User, direction: Direction) {
        let fn = direction == .offer ? self.peerConnection.offer : self.peerConnection.answer
        
        fn(RTCMediaConstraints(mandatoryConstraints: self.mediaConstrains, optionalConstraints: nil)) { sdp, error in
            guard let sdp = sdp else { return }
            
            self.peerConnection.setLocalDescription(sdp) { error in
                let request = WebRTCSignalingRequest.with {
                    $0.type = .sdp
                    $0.sdp = sdp.sdp
                    $0.sdpType = Int32(sdp.type.rawValue)
                    $0.sdpDescription = sdp.description
                    $0.user = srcUser
                }
                
                self.socket?.send(.data(try! request.serializedData())) { err in
                    if let err = err { debugPrint(err.localizedDescription) }
                }
            }
        }
    }
    
    func offer(from a: User, to b: User) { connect(from: a, to: b, direction: .offer) }
    func answer(from a: User, to b: User) { connect(from: a, to: b, direction: .answer) }
}
