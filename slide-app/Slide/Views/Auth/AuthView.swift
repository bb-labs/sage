import SwiftUI
import AuthenticationServices

struct AuthView: View {
    @EnvironmentObject var userModel: UserModel
    
    var body: some View {
        ZStack {
            IntroView()
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                Spacer()
                
                SignInWithAppleButton(.continue,
                                      onRequest: userModel.auth.requestAppleScopes,
                                      onCompletion: userModel.auth.onAppleSignUpComplete)
                    .frame(width: 300, height: 45)
                    .cornerRadius(50)
                    .signInWithAppleButtonStyle(.white)
                
                HStack {
                    Text("Terms of Service").underline()
                    Text("Privacy Policy").underline()
                }
                .font(.caption2)
            }
        }
    }
}
