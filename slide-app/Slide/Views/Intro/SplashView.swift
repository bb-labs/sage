
import Foundation
import SwiftUI

struct SplashView<Content: View>: View {
    @State var size = 0.8
    @State var opacity = 0.4
    @State var isComplete = false
    
    @ViewBuilder var content: Content
    
    var body: some View {
        if isComplete {
            content
        } else {
            ZStack {
                Color(.white).ignoresSafeArea()
                
                VStack {
                    Image("AppLogo")
                        .resizable()
                        .frame(width: 128, height: 128)
                        .scaleEffect(self.size)
                        .opacity(self.opacity)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.2)) {
                                self.size = 1.5
                                self.opacity = 1.0
                            }
                        }
                }
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeIn(duration: 2)) {
                        self.isComplete.toggle()
                    }
                }
            }
        }
    }
}
