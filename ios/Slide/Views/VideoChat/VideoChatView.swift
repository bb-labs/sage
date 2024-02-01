
import SwiftUI
import WebRTC

struct VideoChatView: View {
    @ObservedObject var webRTCModel: WebRTCModel
    
    var body: some View {
        CameraVideoChatPeerView(webRTCModel: webRTCModel)
            .ignoresSafeArea(.all, edges: .all)
            .overlay {
                CameraVideoChatSelfView(webRTCModel: webRTCModel)
            }
            .overlay {
                HStack {
                    Button("Offer") {
                        webRTCModel.offer()
                    }
                    Button("Answer") {
                        webRTCModel.answer()
                    }
                    Button("Video") {
                        webRTCModel.setTrackEnabled(RTCVideoTrack.self, isEnabled: true)
                        webRTCModel.renderRemoteVideo()
                    }
                }
            }
    }
}
