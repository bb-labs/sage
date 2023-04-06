
import SwiftUI

struct TextButtonView: View {
    var size: CGSize
    var text: String
    
    var body: some View {
        Text(text)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: size.width * 0.4)
            .padding()
            .background {
                Capsule()
                    .fill(Color("Main"))
            }
    }
}

