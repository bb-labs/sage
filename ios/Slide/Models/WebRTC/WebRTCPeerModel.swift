
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
        Task {
            var message = RTCMessage.with {
                $0.ice = ICE.with {
                    $0.lineIndex = candidate.sdpMLineIndex
                    $0.sdp = SDP.with {$0.message = candidate.sdp}
                }
            }
            
            if let streamID = candidate.sdpMid { message.ice.streamID = streamID }
            if let serverURL = candidate.serverUrl { message.ice.serverURL = serverURL }
            
            do {
                print("sent ice")
                try await self.messenger.requestStream.send(MessageUserRequest.with {
                    $0.recipient = recipient
                    $0.messages = [Message.with { $0.rtc = message}]
                })
            }
            catch let error {
                print(error)
                return
            }
        }
    }
    

    func listen() {
        Task {
            do {
                for try await message in self.messenger.responseStream {
                    switch message.data {
                    case .rtc(let rtc):
                        print("got message")
//                        switch rtc.format {
//                        case .sdp(let sdp):
//                            print("sdp")
//                            try await self.peerConnection.setRemoteDescription(RTCSessionDescription(
//                                type: RTCSdpType(rawValue: Int(sdp.type))!,
//                                sdp: sdp.message
//                            ))
//                        case .ice(let ice):
//                            print("ice")
//                            try await self.peerConnection.add(RTCIceCandidate(
//                                sdp: ice.sdp.message,
//                                sdpMLineIndex: ice.lineIndex,
//                                sdpMid: ice.streamID
//                            ))
//                        default:
//                            debugPrint("Error: only ice and sdp are supported rtc messages")
//                        }

                    default:
                        debugPrint("Skipping non-rtc messages")
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
            
            print("all messages read: ")
        }
    }
    
    enum Direction { case offer, answer }
    private func connect(direction: Direction) {
        let fn = direction == .offer ? self.peerConnection.offer : self.peerConnection.answer
        
        fn(RTCMediaConstraints(mandatoryConstraints: self.mediaConstrains, optionalConstraints: nil)) { sdp, error in
            guard let sdp = sdp else { return }
            
            self.peerConnection.setLocalDescription(sdp) { error in
                Task {
                    print("sent sdp")
                    try await self.messenger.requestStream.send(MessageUserRequest.with {
                        $0.recipient = self.recipient
                        $0.messages = [Message.with{
                            $0.rtc = RTCMessage.with {
                                $0.sdp = SDP.with {
                                    $0.message = sdp.sdp
                                    $0.type = Int32(sdp.type.rawValue)
                                    $0.description_p = sdp.description
                                }
                            }
                        }]
                    })
                }
            }
        }
    }
    
    func offer() { connect(direction: .offer) }
    func answer() { connect(direction: .answer) }
}
