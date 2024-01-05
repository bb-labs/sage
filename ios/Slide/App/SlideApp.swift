
import SwiftUI

@main
struct SlideApp: App {
    @UIApplicationDelegateAdaptor var app: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            SlideView()
                .environmentObject(app.cameraModel)
                .environmentObject(app.userModel)
                .environmentObject(app.introModel)
        }
    }
}

class AppDelegate: NSObject, ObservableObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    let userModel = UserModel()
    let introModel = IntroModel()
    let cameraModel = CameraModel()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError err: Error) {
        debugPrint("Couldn't register device token! \(err)")
    }
}
