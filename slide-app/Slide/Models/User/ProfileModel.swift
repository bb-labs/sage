
import Foundation

class ProfileModel: ObservableObject {
    enum Gender: String, Codable {
        case MALE = "M"
        case FEMALE = "F"
        case PERSON = "P"
    }

    var video: Data?
    var name: String?
    var gender: Gender?
    var seeking: Gender?
    var locationRadius: Int?
    var birthday: Int?
    var location: Location?
}
