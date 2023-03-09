import Foundation
import CoreLocation

struct SlideCreateUser: APICall {
    struct User: Codable {
        var id: String
        var email: String?
    }
    
    struct Request: Codable {
        var user: User
    }
    
    struct Response: Codable {
        let refreshToken: String
        let identityToken: String
    }
    
    init(id: String, email: String?, authorizationCode: String) {
        self.request = Request(user: User(id: id, email: email))
        self.authorizationCode = authorizationCode
    }
    
    var authorizationCode: String
    
    var url = "http://10.0.0.40:3000/user"
    var request: Request
    var method = APIMethod.POST
    var queryParams: [URLQueryItem] {
        return [URLQueryItem(name: "authorization_code", value: authorizationCode)]
    }
}


