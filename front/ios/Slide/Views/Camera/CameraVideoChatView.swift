
import SwiftUI

struct CameraVideoChatView: View {
    @EnvironmentObject var cameraModel: CameraModel
    @EnvironmentObject var webRTCModel: WebRTCModel
    @EnvironmentObject var userModel: UserModel
    
    var body: some View {
        CameraVideoChatPeerView()
            .ignoresSafeArea(.all, edges: .all)
            .overlay {
                CameraVideoChatSelfView()
            }
    }
}
