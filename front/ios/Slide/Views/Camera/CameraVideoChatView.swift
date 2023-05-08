
import SwiftUI

struct CameraVideoChatView: View {
    @EnvironmentObject var cameraModel: CameraModel
    @EnvironmentObject var webRTCModel: WebRTCModel
    
    var body: some View {
        CameraLiveView()
            .ignoresSafeArea(.all, edges: .all)
        
        Button {
            
        } label: {
            "Hi!!"
        }
    }
}

