
import SwiftUI

struct SlideView: View {
    @EnvironmentObject var userModel: UserModel
    
    var body: some View {
        SplashView {
            if userModel.profile != nil {
                CreateProfileView()
            } else if userModel.auth.loggedIn {
                WelcomeView()
            } else {
                AuthView()
            }
        }
    }
}
