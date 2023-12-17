import Foundation
import CoreLocation
import SwiftProtobuf
import AuthenticationServices

struct SlideCreateUser: APICall {
    var user: User
    var credentials: AppleCredentials
    
    var url = "https://sage.dating/user"
    var method = APIMethod.POST
    var body: Data? { return try! user.serializedData() }
}


