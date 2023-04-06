import Foundation

class ProfileModel: NSObject, ObservableObject {
    enum Gender: String, Codable {
        case MALE = "M"
        case FEMALE = "W"
        case PERSON = "P"
    }
    

    var video: Data?
    var name: String?
    var gender: Gender?
    var seeking: [Gender]?
    var locationRadius: Int?
    var birthday: Int?
    var location: Location?
}


