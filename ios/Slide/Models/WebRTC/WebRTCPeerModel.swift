
import Foundation
import WebRTC

extension WebRTCModel: RTCPeerConnectionDelegate {
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange stateChanged: RTCSignalingState) {
        debugPrint("peerConnection new signaling state: \(stateChanged)")
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didAdd stream: RTCMediaStream) {
        debugPrint("peerConnection did add stream \(stream)")
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove stream: RTCMediaStream) {
        debugPrint("peerConnection did remove stream")
    }
    
    func peerConnectionShouldNegotiate(_ peerConnection: RTCPeerConnection) {
        debugPrint("peerConnection should negotiate")
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceConnectionState) {
        debugPrint("peerConnection new connection state: \(newState)")
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceGatheringState) {
        debugPrint("peerConnection new gathering state: \(newState)")
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove candidates: [RTCIceCandidate]) {
        debugPrint("peerConnection did remove candidate(s)")
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didOpen dataChannel: RTCDataChannel) {
        debugPrint("peerConnection did open data channel")
    }
    
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate candidate: RTCIceCandidate) {
        var iceRequest = SignalingRequest.with {
            $0.ice = ICE.with {
                $0.lineIndex = candidate.sdpMLineIndex
                $0.sdp = SDP.with {
                    $0.message = candidate.sdp
                }
            }
        }
        
        if let streamID = candidate.sdpMid { iceRequest.ice.streamID = streamID }
        if let serverURL = candidate.serverUrl { iceRequest.ice.serverURL = serverURL }

        print("sent ice")
        self.socket?.send(.data(try! iceRequest.serializedData())) { err in
            if let err = err {
                debugPrint("peerConnection couldn't send ICE candidate: err \(err.localizedDescription)")
            }
        }
    }
    

    func listen() {
        self.socket?.receive { message in
            switch message {
            case .success(.data(let data)):
                do {
                    let request = try SignalingRequest(serializedData: data)
                    
                    switch request.message {
                    case .sdp(let sdp):
                        let sdp = RTCSessionDescription(
                            type: RTCSdpType(rawValue: Int(sdp.type))!,
                            sdp: sdp.message
                        )
                        
                        debugPrint("remote got a new sdp")
                        
                        self.peerConnection?.setRemoteDescription(sdp) { err in
                            if let err = err { debugPrint(err.localizedDescription) }
                        }
                    case .ice(let ice):
                        let candidate = RTCIceCandidate(
                            sdp: ice.sdp.message,
                            sdpMLineIndex: ice.lineIndex,
                            sdpMid: ice.streamID
                        )
                        
                        debugPrint("remote got a new candidate")
                        
                        self.peerConnection?.add(candidate) { err in
                            if let err = err { debugPrint(err.localizedDescription) }
                        }
                    default:
                        debugPrint("error: expected either ice or sdp")
                        return
                    }
                    
                    self.listen()
                }
                catch {
                    debugPrint("Failed to parse signaling data. \(error.localizedDescription)")
                    print(error)
                }
            case .success:
                debugPrint("Warning: Expected to receive data format. Check the websocket server config.")
            case .failure:
                debugPrint("Failed to recieve data")
            }
        }
    }
    
    enum Direction { case offer, answer }
    private func connect(direction: Direction) {
        let fn = direction == .offer ? self.peerConnection?.offer : self.peerConnection?.answer
        
        fn?(RTCMediaConstraints(mandatoryConstraints: self.mediaConstrains, optionalConstraints: nil)) { sdp, error in
            guard let sdp = sdp else { return }
            
            self.peerConnection?.setLocalDescription(sdp) { error in
                let sdpRequest = SignalingRequest.with {
                    $0.sdp = SDP.with {
                        $0.message = sdp.sdp
                        $0.type = Int32(sdp.type.rawValue)
                        $0.description_p = sdp.description
                    }
                }
                
                print("sent sdp")
                self.socket?.send(.data(try! sdpRequest.serializedData())) { err in
                    if let err = err { debugPrint(err.localizedDescription) }
                }
            }
        }
    }
    
    func offer() { connect(direction: .offer) }
    func answer() { connect(direction: .answer) }
}
