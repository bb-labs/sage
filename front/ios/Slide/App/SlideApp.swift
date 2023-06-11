
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
    let webRTCModel = WebRTCModel()
    let cameraModel = CameraModel()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success,_ in
            print("Success: ", success)
        }
        UIApplication.shared.registerForRemoteNotifications()
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        AuthModel.shared.credentials.append(DeviceCredentials(
            deviceToken: deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        ))
        
        self.webRTCModel.startSignaling()
    }
}
