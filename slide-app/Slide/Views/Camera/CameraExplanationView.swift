
import SwiftUI

struct CameraExplanationView: View {
    var body: some View {
        let deviceSize = UIScreen.main.bounds.size
        
        VStack(spacing: 10) {
            Text("🎉 You Are Your Profile 🎉")
                .font(.title2)
            
            Text("We didn't lie to you, this is your profile. Record a ten second video of you being you. Say hi, introduce yourself, and try not to film it 30 times 😉")
                .font(.callout)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(width: deviceSize.width * 0.85, height:  deviceSize.height * 0.25)
        .background(Color("Background"), in: RoundedRectangle(cornerRadius: 32.0))
    }
}
