
import SwiftUI

struct DoubleChevronView: View {
    @Binding var pageIndex: Int
    var disabled = false
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            
            Button {
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                withAnimation(.easeInOut) {
                    pageIndex -= 1
                }
            } label: {
                ChevronView(direction: "left")
            }
            .frame(maxWidth: .infinity)
            
            Button {
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                withAnimation(.easeInOut) {
                    pageIndex += 1
                }
            } label: {
                ChevronView(direction: "right", disabled: disabled)
            }
            .frame(maxWidth: .infinity)
            .disabled(disabled)
            
            Spacer()
        }
    }
}
