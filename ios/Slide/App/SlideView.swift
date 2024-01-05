
import SwiftUI
import WebRTC

struct SlideView: View {
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var cameraModel: CameraModel
    @EnvironmentObject var webRTCModel: WebRTCModel
    @EnvironmentObject var sageModel: SageModel
    
    var body: some View {
        AuthView()
    }
}
