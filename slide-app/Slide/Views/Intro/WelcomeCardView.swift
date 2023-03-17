
import SwiftUI

struct WelcomeCardView: View {
    @EnvironmentObject var userModel: UserModel
    
    @Binding var card: WelcomeCard

    @State var scale = 1.0
    @State var spring = 0.4


    var size: CGSize
    var last: Bool

    var body: some View {
        VStack(spacing: 25) {
            LottieView(card: $card)
                .frame(height: size.width)
                .onAppear {
                    card.gif.play()
                }
            
            Text(card.title)
                .font(.title.bold())
            
            Text(card.description)
                .font(.callout)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 300)
                
            Spacer()
            
            if last {
                Button(action: {
                    userModel.createProfile()
                }) {
                    Text("Let's Go")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background {
                            Capsule()
                                .fill(Color(.systemBlue))
                        }
                        .padding(.horizontal, 50)
                }
            }
            
            Spacer()
        }
    }
}

