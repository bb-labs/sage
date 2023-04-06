
import SwiftUI

struct ProfileInputView<Content: View>: View {
    var heading: String
    @Binding var pageIndex: Int
    @ViewBuilder var ContentView: Content
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            VStack {
                Text(heading)
                    .font(.system(size: 30))
                    .foregroundColor(Color("Main"))
                    .fontWeight(.black)
                    .padding(.top, size.height * 0.1)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                ContentView
                
                Spacer()
                
                if pageIndex <= 0 {
                    NextButtonView(pageIndex: $pageIndex, size: size)
                } else {
                    DoubleChevronView(pageIndex: $pageIndex)
                }
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .simultaneousGesture(DragGesture())
    }
}

