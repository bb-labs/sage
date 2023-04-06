
import SwiftUI

struct DayLocationData: Equatable {
    var day: String
    var bounds: CGRect
}

struct DayLocationKey: PreferenceKey {
    static var defaultValue: [DayLocationData] = []

    static func reduce(value: inout [DayLocationData], nextValue: () -> [DayLocationData]) {
        value.append(contentsOf: nextValue())
    }
}

struct ScheduleView: View {
    var size: CGSize
    
    @State var selectedDay = "Mon" {
        didSet {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        }
    }
    
    @State var daysOfTheWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    @State var dayScreenLocations: [DayLocationData] = []
    
    var body: some View {
        VStack {
            HStack {
                ForEach(daysOfTheWeek, id: \.self) { day in
                    GeometryReader { geometry in
                        ZStack {
                            RoundedRectangle(cornerRadius: 30, style: .circular)
                                .fill(day == selectedDay ? Color("Main") : .white)
                                .preference(
                                    key: DayLocationKey.self,
                                    value: [DayLocationData(day: day, bounds: geometry.frame(in: .named("DayPicker")))]
                                )
                                .onTapGesture {
                                    selectedDay = day
                                }
                            
                            VStack(spacing: 3) {
                                Text(day)
                                    .font(.system(size: 12))
                                    .fontWeight(.semibold)
                                    .foregroundColor(day == selectedDay ? .white : .gray)
                                
                                Circle()
                                    .fill(.white)
                                    .frame(width: 4, height: 4)
                                    .opacity(day == selectedDay ? 1 : 0)
                            }
                        }
                        .frame(width: size.width * 0.1, height: size.width * 0.1)
                    }
                }
            }
            .onPreferenceChange(DayLocationKey.self) { dayScreenLocations in
                self.dayScreenLocations = dayScreenLocations
            }
            .frame(maxWidth: size.width * 0.85)
            .gesture(DragGesture().onChanged { drag in
                if let dayLocationData = dayScreenLocations.first(where: { $0.bounds.contains(drag.location) }) {
                    if dayLocationData.day != selectedDay {
                        selectedDay = dayLocationData.day
                    }
                }
            })
            .coordinateSpace(name: "DayPicker")

        }.padding(.top)
    }
}

