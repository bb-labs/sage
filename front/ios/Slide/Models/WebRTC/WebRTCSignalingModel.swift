

import Foundation
import WebRTC

extension WebRTCModel {
    func listen() {
        self.signalingClient.socket?.receive { message in
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
    
    private func connect(to user: User, direction: Direction) {
        let fn = direction == .offer ? self.peerConnection.offer : self.peerConnection.answer
        
        fn(RTCMediaConstraints(mandatoryConstraints: self.mediaConstrains, optionalConstraints: nil)) { sdp, error in
            guard let sdp = sdp else { return }
            
            self.peerConnection.setLocalDescription(sdp) { error in
                let request = WebRTCSignalingRequest.with {
                    $0.type = .sdp
                    $0.sdp = sdp.sdp
                    $0.sdpType = Int32(sdp.type.rawValue)
                    $0.sdpDescription = sdp.description
                    $0.user = user
                }
                
                self.signalingClient.socket?.send(.data(try! request.serializedData())) { err in
                    if let err = err { debugPrint(err.localizedDescription) }
                }
            }
        }
    }
    
    func offer(to user: User) { connect(to: user, direction: .offer) }
    func answer(to user: User) { connect(to: user, direction: .answer) }
}
