

import SwiftUI

struct NextButtonView: View {
    @Binding var pageIndex: Int
    var size: CGSize
    
    
    var body: some View {
        Button {
            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            
            withAnimation(.easeInOut) {
                pageIndex += 1
            }
        } label: {
            TextButtonView(size: size, text: "Next")
        }.frame(maxWidth: .infinity)
    }
}

