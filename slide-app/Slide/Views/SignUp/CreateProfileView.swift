
import Foundation
import SwiftUI

struct CreateProfileView: View {
    @EnvironmentObject var userModel: UserModel
    
    @State var pageIndex = 0
    @State var identifyAs = ["Man": false, "Woman": false, "Person": false]
    @State var interestedIn = ["Men": false, "Women": false, "People": false]
    

    var body: some View {
        TabView(selection: $pageIndex) {
            PreferencesSelectionView(heading: "I'm a..", selections: $identifyAs, pageIndex: $pageIndex)
                .tag(0)
            
            PreferencesSelectionView(heading: "Looking for..", multiSelect: true, selections: $interestedIn, pageIndex: $pageIndex)
                .tag(1)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

