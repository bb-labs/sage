import SwiftUI
import Foundation
import AuthenticationServices
import Lottie

struct AuthView: View {
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var introModel: IntroModel
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ZStack {
                VStack {
                    Text("Sage")
                        .font(.custom("AmericanTypewriter", fixedSize: 40).weight(.black))
                        .padding(.bottom)
                    
                    Text("Keep the Ghosts Away")
                        .font(.custom("AmericanTypewriter", fixedSize: 15).weight(.regular))
                        .padding(.bottom)
                    
                    LottieView(gif: $introModel.swayingSageGif)
                        .frame(height: size.width)
                        .padding(.leading, 25)
                        .onAppear {
                            introModel.swayingSageGif.play()
                        }.overlay(alignment: .top) {
                            LottieView(gif: $introModel.fleeingGhostGif)
                                .frame(height: size.width)
                                .onAppear {
                                    introModel.fleeingGhostGif.play()
                                }
                        }
                }
                
                VStack {
                    Spacer()
                    
                    SignInWithAppleButton(.continue,
                                          onRequest: userModel.auth.requestAppleScopes,
                                          onCompletion: userModel.auth.onAppleSignUpComplete)
                        .frame(width: 300, height: 45)
                        .cornerRadius(50)
                        .signInWithAppleButtonStyle(.black)
                    
                    HStack {
                        Text("Terms of Service").underline()
                        Text("Privacy Policy").underline()
                    }
                    .font(.caption2)
                }
            }
        }
    }
}
