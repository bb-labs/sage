
import SwiftUI

@main
struct SlideApp: App {
    let userModel = UserModel()
    let introModel = IntroModel()
    let cameraModel = CameraModel()
    
    var body: some Scene {
        WindowGroup {
            SlideView()
                .environmentObject(cameraModel)
                .environmentObject(userModel)
                .environmentObject(introModel)
        }
    }
}
