
import SwiftUI
import WebRTC

struct SlideView: View {
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var cameraModel: CameraModel
    @EnvironmentObject var webRTCModel: WebRTCModel
    
    var body: some View {
        CameraVideoChatView()
            .overlay {
                HStack {
                    Button("Offer") {
                        webRTCModel.offer(to: userModel.user)
                    }
                    Button("Answer") {
                        webRTCModel.answer(to: userModel.user)
                    }
                    Button("Video") {
                        webRTCModel.setTrackEnabled(RTCVideoTrack.self, isEnabled: true)
                        webRTCModel.renderRemoteVideo()
                    }
                    Button("Hello") {
                        webRTCModel.signalingClient.socket?.send(.string("Hello!")) { err in
                            if let err = err {
                                debugPrint(err)
                            }
                        }
                    }
                }
            }
    }
}
