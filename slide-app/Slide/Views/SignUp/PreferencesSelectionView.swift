
import SwiftUI

struct PreferencesSelectionView: View {
    var heading: String
    var multiSelect = false
    @Binding var selections: [String:Bool]
    @Binding var pageIndex: Int
    
    
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
                
                SelectButtonsView(size: size, multiSelect: multiSelect, selections: $selections)
                
                Spacer()
                
                if pageIndex <= 0 {
                    NextButtonView(pageIndex: $pageIndex, size: size)
                } else {
                    DoubleChevronView(pageIndex: $pageIndex)
                }
                
                Spacer()
            }
        }
    }
}


