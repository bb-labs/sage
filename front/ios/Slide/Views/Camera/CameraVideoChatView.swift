
import SwiftUI

struct CameraVideoChatView: View {
    @EnvironmentObject var cameraModel: CameraModel
    
    var body: some View {
        CameraLiveView()
            .ignoresSafeArea(.all, edges: .all)
    }
}

