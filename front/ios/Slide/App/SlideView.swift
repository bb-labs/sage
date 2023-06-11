
import SwiftUI

struct SlideView: View {
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var cameraModel: CameraModel
    @EnvironmentObject var webRTCModel: WebRTCModel
    
    var body: some View {
        CameraVideoChatView()
            .onAppear {
                webRTCModel.offer(to: userModel.user)
            }
    }
}
