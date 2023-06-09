import Foundation
import CoreLocation
import SwiftProtobuf

struct SlideCreateUser: APICall {
    var user: User
    var authCode: String
    
    var url = "http://10.0.0.40:3000/user"
    var method = APIMethod.POST
    var body: Data? { return try! user.serializedData() }
    var queryParams: [URLQueryItem] {
        return [URLQueryItem(name: "authorization_code", value: authCode)]
    }
}


