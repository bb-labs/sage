
import SwiftUI
import WebRTC

struct SlideView: View {
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var cameraModel: CameraModel
    
    var body: some View {
        AuthView()
    }
}
