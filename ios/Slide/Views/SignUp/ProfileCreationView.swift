
import Foundation
import SwiftUI

struct CreateProfileView: View {
    @EnvironmentObject var userModel: UserModel
    
    @State var pageIndex = 0
        
    let minimumAge = Calendar.current.date(byAdding: .year, value: -18, to: .now)!
    @State var birthDate = Calendar.current.date(byAdding: .year, value: -18, to: .now)!
    
    
    @State var identifyAs = [
        String(describing: Gender.man.rawValue): false,
        String(describing: Gender.woman.rawValue): false,
        String(describing: Gender.human.rawValue): false
    ]
    
    @State var interestedIn = [
        String(describing: Gender.man.rawValue): false,
        String(describing: Gender.woman.rawValue): false,
        String(describing: Gender.human.rawValue): false
    ]
    
    @State var locationRadius = [
        String(describing: Proximity.neighborhood.rawValue): false,
        String(describing: Proximity.city.rawValue): false,
        String(describing: Proximity.metro.rawValue): false,
        String(describing: Proximity.state.rawValue): false
    ]
    

    var body: some View {
        GeometryReader {
            let size = $0.size
            TabView(selection: $pageIndex) {
                ProfileInputView(
                    pageIndex: $pageIndex,
                    heading: "What's your birthday?",
                    errorMessage: "You must be 18 to sign up!",
                    validate: { birthDate < minimumAge }) {
                    DatePicker("Birthday", selection: $birthDate, displayedComponents: .date)
                        .datePickerStyle(.wheel)
                        .frame(width: size.width * 0.8)
                        .accentColor(Color("Main"))
                        .labelsHidden()
                }.tag(0)
                
                ProfileInputView(
                    pageIndex: $pageIndex,
                    heading: "How would you like to be identified?",
                    errorMessage: "Please let us know how you identify!",
                    validate: { identifyAs.values.contains { $0 } }) {
                    SelectOptionsView(size: size, selections: $identifyAs)
                }.tag(1)
                
                ProfileInputView(
                    pageIndex: $pageIndex,
                    heading: "Who would you like to connect with?",
                    errorMessage: "Let us know who you are interested in meeting!",
                    validate: { interestedIn.values.contains { $0 } }) {
                    SelectOptionsView(size: size, multiSelect: true, selections: $interestedIn)
                }.tag(2)
                
                ProfileInputView(
                    pageIndex: $pageIndex,
                    heading: "How far would you travel for a date?",
                    errorMessage: "Help us understand your willingness to travel!",
                    validate: { locationRadius.values.contains { $0 } }) {
                    SelectOptionsView(size: size, multiSelect: false, selections: $locationRadius, ordering: [
                        String(describing: Proximity.neighborhood.rawValue),
                        String(describing: Proximity.city.rawValue),
                        String(describing: Proximity.metro.rawValue),
                        String(describing: Proximity.state.rawValue)
                    ])
                }.tag(3)
                
                CameraView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(Rectangle())
                    .simultaneousGesture(DragGesture())
                    .tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea(.all, edges: .all)
        }
    }
}


