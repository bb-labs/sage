
import SwiftUI

struct ProfileInputView<Content: View>: View {
    @Binding var pageIndex: Int
    var heading: String
    var spacers = true
    var errorMessage: String
    var validate: () -> Bool
    @ViewBuilder var ContentView: Content
    
    @State var triedToProceed = false
    
    
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
                    .frame(maxWidth: size.width * 0.8)
                
                Spacer(minLength: size.height * 0.1)
                
                ContentView
                
                Spacer()
                
                Text(errorMessage)
                    .font(.callout)
                    .foregroundColor(.red)
                    .opacity((triedToProceed && !validate()) ? 1 : 0)
                    .frame(maxWidth: size.width * 0.8)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                if pageIndex <= 0 {
                    NextButtonView(pageIndex: $pageIndex, size: size, disabled: !validate())
                        .onTapGesture { triedToProceed = true }
                } else {
                    DoubleChevronView(pageIndex: $pageIndex, disabled: !validate())
                        .onTapGesture { triedToProceed = true }
                }
                
                Spacer(minLength: size.height * 0.15)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .simultaneousGesture(DragGesture())
    }
}

