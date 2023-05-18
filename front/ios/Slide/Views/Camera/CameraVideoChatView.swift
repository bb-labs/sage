
import SwiftUI

struct CameraVideoChatView: View {
    @EnvironmentObject var cameraModel: CameraModel
    @EnvironmentObject var webRTCModel: WebRTCModel
    
    var body: some View {
        CameraVideoChatPeerView()
            .ignoresSafeArea(.all, edges: .all)
            .overlay {
                CameraVideoChatSelfView()
            }
    }
}
