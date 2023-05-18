
import SwiftUI

@main
struct SlideApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    let userModel = UserModel()
    let introModel = IntroModel()
    let cameraModel = CameraModel()
    let webRTCModel = WebRTCModel()
    
    var body: some Scene {
        WindowGroup {
            SlideView()
                .environmentObject(cameraModel)
                .environmentObject(userModel)
                .environmentObject(introModel)
                .environmentObject(webRTCModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success,_ in
            print("Success: ", success)
        }
        
        UIApplication.shared.registerForRemoteNotifications()
        return true
    }
    
    func application(_ application: UIApplication,
                didRegisterForRemoteNotificationsWithDeviceToken
                    deviceToken: Data) {
        print("Token: ", deviceToken)
    }
}
