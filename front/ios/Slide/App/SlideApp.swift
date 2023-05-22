
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
                .environmentObject(app.webRTCModel)
        }
    }
}

class AppDelegate: NSObject, ObservableObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    let userModel = UserModel()
    let introModel = IntroModel()
    let cameraModel = CameraModel()
    let webRTCModel = WebRTCModel()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success,_ in
            print("Success: ", success)
        }
        UIApplication.shared.registerForRemoteNotifications()
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.userModel.addCredential(DeviceCredentials(
            deviceToken: String(decoding: deviceToken, as: UTF8.self)
        ))
    }
}
