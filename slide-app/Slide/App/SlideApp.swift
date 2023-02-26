
import SwiftUI

@main
struct SlideApp: App {
    let userModel = UserModel()
    let cameraModel = CameraModel()
    let locationModel = LocationModel()
    let introModel = IntroModel()
    
    var body: some Scene {
        WindowGroup {
            SlideView()
                .environmentObject(cameraModel)
                .environmentObject(locationModel)
                .environmentObject(userModel)
                .environmentObject(introModel)
        }
    }
}
