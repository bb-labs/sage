import Foundation
import CoreLocation

struct SlideUpdateLocation: APICall {
    var location: Location
    
    var url = "http://10.0.0.40:3000/locate"
    var body: Data? { try! location.serializedData() }
    var method = APIMethod.POST
    
    struct Response: Codable {
        let status: String
    }
}


