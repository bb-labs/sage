import Foundation

class ProfileModel: NSObject, ObservableObject {
    enum Gender: String, Codable {
        case MAN = "Man"
        case MEN = "Men"
        case WOMAN = "Woman"
        case WOMEN = "Women"
        case HUMAN = "Human"
        case HUMANS = "Humans"
    }
    
    enum MeetingTime: String, Codable {
        case MORNING = "6AM - 10AM"
        case EARLY_AFTERNOON = "10AM - 2PM"
        case LATE_AFTERNOON = "2PM - 6PM"
        case EVENING = "6PM - 10PM"
    }
    

    var video: Data?
    var name: String?
    var gender: Gender?
    var seeking: [Gender]?
    var locationRadius: Int?
    var birthday: Int?
    var location: Location?
    var schedule: [MeetingTime]?
}


