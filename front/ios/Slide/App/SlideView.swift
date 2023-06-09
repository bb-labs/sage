
import SwiftUI

struct SlideView: View {
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var cameraModel: CameraModel
    @EnvironmentObject var webRTCModel: WebRTCModel
    
    var body: some View {
        Button("Offer") {
            webRTCModel.offer(from: userModel.user, to: userModel.user)
        }
        
        CameraVideoChatPeerView()
            .ignoresSafeArea(.all, edges: .all)
            .overlay {
                CameraVideoChatSelfView()
            }
    }
}
