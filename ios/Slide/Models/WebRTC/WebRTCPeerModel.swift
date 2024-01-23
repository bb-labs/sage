
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
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate candidate: RTCIceCandidate) {
        var iceRequest = SignalingRequest.with {
            $0.ice = ICERequest.with {
                $0.lineIndex = candidate.sdpMLineIndex
                $0.sdp = SDPRequest.with {
                    $0.message = candidate.sdp
                }
            }
        }
        
        if let streamID = candidate.sdpMid { iceRequest.ice.streamID = streamID }
        if let serverURL = candidate.serverUrl { iceRequest.ice.serverURL = serverURL }

//        self.signalingClient.socket?.send(.data(try! iceRequest.serializedData())) { err in
//            if let err = err {
//                debugPrint("peerConnection couldn't send ICE candidate: err \(err.localizedDescription)")
//            }
//        }
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove candidates: [RTCIceCandidate]) {
        debugPrint("peerConnection did remove candidate(s)")
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didOpen dataChannel: RTCDataChannel) {
        debugPrint("peerConnection did open data channel")
    }
}
