
import Foundation
import SwiftUI

struct CreateProfileView: View {
    @EnvironmentObject var userModel: UserModel
    
    @State var pageIndex = 0
    @State var birthDate = Date.now
    @State var identifyAs = ["Man": false, "Woman": false, "Person": false]
    @State var interestedIn = ["Men": false, "Women": false, "People": false]
    

    var body: some View {
        GeometryReader {
            let size = $0.size
            TabView(selection: $pageIndex) {
                ProfileInputView(heading: "I Was Born On..", pageIndex: $pageIndex) {
                    DatePicker("Birthday", selection: $birthDate, displayedComponents: .date)
                        .datePickerStyle(.wheel)
                        .frame(width: size.width * 0.8)
                        .accentColor(Color("Main"))

                }
                .tag(0)
                
                
                ProfileInputView(heading: "I Identify As A..", pageIndex: $pageIndex) {
                    SelectOptionsView(size: size, selections: $identifyAs)
                }.tag(1)
                
                ProfileInputView(heading: "Looking To Meet..", pageIndex: $pageIndex) {
                    SelectOptionsView(size: size, multiSelect: true, selections: $interestedIn)
                }.tag(2)
                
                ProfileInputView(heading: "I'm Free For Dates..", pageIndex: $pageIndex, sticky: .top) {
                    ScheduleView(size: size)
                }.tag(3)
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
}

