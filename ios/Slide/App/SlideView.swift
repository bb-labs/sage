
import SwiftUI
import WebRTC

struct SlideView: View {
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var cameraModel: CameraModel
    @EnvironmentObject var webRTCModel: WebRTCModel
    
    var body: some View {
        AuthView()
    }
}
