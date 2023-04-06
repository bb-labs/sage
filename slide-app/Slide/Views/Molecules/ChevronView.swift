
import SwiftUI

struct ChevronView: View {
    var direction: String
    
    var body: some View {
        Image(systemName: "chevron.\(direction)")
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: 55, height: 55)
            .background {
                RoundedRectangle(cornerRadius: 30, style: .circular)
                    .fill(Color("Main"))
            }
    }
}
