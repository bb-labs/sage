
import Foundation
import SwiftUI

struct CreateProfileView: View {
    @EnvironmentObject var userModel: UserModel
    
    @State var pageIndex = 0
        
    let minimumAge = Calendar.current.date(byAdding: .year, value: -18, to: .now)!
    @State var birthDate = Date.now
    
    
    @State var identifyAs = [
        ProfileModel.Gender.MAN.rawValue: false,
        ProfileModel.Gender.WOMAN.rawValue: false,
        ProfileModel.Gender.HUMAN.rawValue: false
    ]
    
    @State var interestedIn = [
        ProfileModel.Gender.MEN.rawValue: false,
        ProfileModel.Gender.WOMEN.rawValue: false,
        ProfileModel.Gender.HUMANS.rawValue: false
    ]
    
    @State var scheduleFree = [
        ProfileModel.MeetingTime.MORNING.rawValue: false,
        ProfileModel.MeetingTime.EARLY_AFTERNOON.rawValue: false,
        ProfileModel.MeetingTime.LATE_AFTERNOON.rawValue: false,
        ProfileModel.MeetingTime.EVENING.rawValue: false
    ]
    

    var body: some View {
        GeometryReader {
            let size = $0.size
            TabView(selection: $pageIndex) {
                ProfileInputView(
                    heading: "What's your birthday?",
                    pageIndex: $pageIndex,
                    errorMessage: "You must be 18 to sign up!",
                    validate: { return birthDate < minimumAge}) {
                    DatePicker("Birthday", selection: $birthDate, displayedComponents: .date)
                        .datePickerStyle(.wheel)
                        .frame(width: size.width * 0.8)
                        .accentColor(Color("Main"))
                }.tag(0)
                
                
                ProfileInputView(
                    heading: "How do you identify?",
                    pageIndex: $pageIndex,
                    errorMessage: "Please let us know how you identify!",
                    validate: { return identifyAs.values.contains { $0 } }) {
                    SelectOptionsView(size: size, selections: $identifyAs)
                }.tag(1)
                
                ProfileInputView(
                    heading: "Who are you looking to meet?",
                    pageIndex: $pageIndex,
                    errorMessage: "Let us know who you are interested in meeting!",
                    validate: { return interestedIn.values.contains { $0 } }) {
                    SelectOptionsView(size: size, multiSelect: true, selections: $interestedIn)
                }.tag(2)
                
                ProfileInputView(
                    heading: "When are you free for dates?",
                    pageIndex: $pageIndex,
                    errorMessage: "Tell us when you're free!",
                    validate: { return scheduleFree.values.contains { $0 } }) {
                    SelectOptionsView(size: size, multiSelect: true, selections: $scheduleFree, ordering: [
                        ProfileModel.MeetingTime.MORNING.rawValue,
                        ProfileModel.MeetingTime.EARLY_AFTERNOON.rawValue,
                        ProfileModel.MeetingTime.LATE_AFTERNOON.rawValue,
                        ProfileModel.MeetingTime.EVENING.rawValue
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


