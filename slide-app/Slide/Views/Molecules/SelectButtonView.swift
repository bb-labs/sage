

import SwiftUI

struct SelectButtonsView: View {
    var size: CGSize
    var multiSelect = false
    @Binding var selections: [String:Bool]
    
    var body: some View {
        ForEach(Array(selections.keys), id: \.self) { selection in
            Button(action: {
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                
                if !multiSelect {
                    selections.keys.forEach { selections[$0] = false }
                }
                
                selections[selection]!.toggle()
            }) {
                Text(selection)
                    .fontWeight(.bold)
                    .foregroundColor(selections[selection]! ? .white : .gray)
                    .padding(.vertical)
                    .frame(maxWidth: size.width * 0.8)
                    .background {
                        Capsule()
                            .fill(selections[selection]! ? Color("Main") : .clear)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 50.0)
                            .stroke(selections[selection]! ? .white : Color("Main"))
                            .frame(maxWidth: size.width * 0.8)
                    )
                    .padding(.horizontal, 50)
            }
        }
    }
}

