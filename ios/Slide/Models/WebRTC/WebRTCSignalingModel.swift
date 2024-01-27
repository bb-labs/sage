

import Foundation
import WebRTC

extension WebRTCModel {
    func listen() {
        self.signalingClient.socket?.receive { message in
            switch message {
            case .success(.data(let data)):
                do {
                    let request = try ConnectUsersRequest(serializedData: data)
                    
                    switch request.message {
                    case .sdp(let sdp):
                        self.peerConnection.setRemoteDescription(RTCSessionDescription(
                            type: RTCSdpType(rawValue: Int(sdp.type))!,
                            sdp: sdp.message
                        )) { err in if let err = err { debugPrint(err.localizedDescription) } }
                    case .ice(let ice):
                        self.peerConnection.add(RTCIceCandidate(
                            sdp: ice.sdp.message,
                            sdpMLineIndex: ice.lineIndex,
                            sdpMid: ice.streamID
                        )) { err in if let err = err { debugPrint(err.localizedDescription) } }
                    default:
                        debugPrint("error: expected either ice or sdp")
                        return
                    }
                    
                    self.listen()
                }
                catch {
                    debugPrint("Failed to parse signaling data. \(error.localizedDescription)")
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
    
    private func connect(to user: User, direction: Direction) {
        let fn = direction == .offer ? self.peerConnection.offer : self.peerConnection.answer
        
        fn(RTCMediaConstraints(mandatoryConstraints: self.mediaConstrains, optionalConstraints: nil)) { sdp, error in
            guard let sdp = sdp else { return }
            
            self.peerConnection.setLocalDescription(sdp) { error in
                let sdpRequest = SignalingRequest.with {
                    $0.sdp = SDPRequest.with {
                        $0.message = sdp.sdp
                        $0.type = Int32(sdp.type.rawValue)
                        $0.description_p = sdp.description
                    }
                }
                
//                self.signalingClient.socket?.send(.data(try! sdpRequest.serializedData())) { err in
//                    if let err = err { debugPrint(err.localizedDescription) }
//                }
            }
        }
    }
    
    func offer(to user: User) { connect(to: user, direction: .offer) }
    func answer(to user: User) { connect(to: user, direction: .answer) }
}
