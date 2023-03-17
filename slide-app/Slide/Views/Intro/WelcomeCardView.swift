
import SwiftUI

struct WelcomeCardView: View {
    @Binding var card: WelcomeCard
    
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
                Text("Let's Go")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background {
                        Capsule()
                            .fill(Color(.systemGreen))
                    }.padding(.horizontal, 50)
            }
            
            Spacer()
        }
    }
}

