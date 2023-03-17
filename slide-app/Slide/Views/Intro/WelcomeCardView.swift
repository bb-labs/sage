
import SwiftUI

struct WelcomeCardView: View {
    @Binding var card: WelcomeCard
    
    var size: CGSize

    var body: some View {
        VStack(spacing: 10) {
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
        }
    }
}

