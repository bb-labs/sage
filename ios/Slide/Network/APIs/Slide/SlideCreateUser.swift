import Foundation
import CoreLocation
import SwiftProtobuf
import AuthenticationServices

struct SlideCreateUser: APICall {
    var user: User
    
    var url = "http://10.0.0.40:3000/user"
    var method = APIMethod.POST
    var body: Data? { return try! user.serializedData() }
}


