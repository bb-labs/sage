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
                
                Text("By tapping 'Continue', you agree to our Terms of Service. Learn how we process your data in our Privacy Policy.")
                    .font(.caption)
                    .padding(.leading)
                    .padding(.trailing)
                
                
                SignInWithAppleButton(.continue,
                                      onRequest: userModel.auth.requestAppleScopes,
                                      onCompletion: userModel.auth.onAppleSignUpComplete)
                    .frame(width: 300, height: 45)
                    .cornerRadius(50)
                    .padding()
                    .signInWithAppleButtonStyle(.white)
            }
        }
    }
}
