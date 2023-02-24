import SwiftUI
import AuthenticationServices

struct AuthView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var introModel: IntroModel
    
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
                
                
                SignInWithAppleButton(.continue) { request in
                    request.requestedScopes = [.fullName, .email]
                } onCompletion: { result in
                    switch result {
                    case .success(let authResults):
                        print("Authorisation successful \(authResults)")
                    case .failure(let error):
                        print("Authorisation failed: \(error.localizedDescription)")
                    }
                }
                .frame(width: 300, height: 45)
                .cornerRadius(50)
                .padding()
                .signInWithAppleButtonStyle(.white)
            }
        }
    }
}
