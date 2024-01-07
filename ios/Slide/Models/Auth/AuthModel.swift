
import Foundation

enum Credential {
    case apple(String)
    case device(String)
}

class AuthModel: NSObject, ObservableObject {
    static let shared = AuthModel()
    
    var credentials: [Credential] = []
}


