
import SwiftUI

struct SlideView: View {
    @EnvironmentObject var cameraModel: CameraModel
    @EnvironmentObject var webRTCModel: WebRTCModel
    
    var body: some View {
        CameraVideoChatSelfView()
            .ignoresSafeArea(.all, edges: .all)
    }
}
