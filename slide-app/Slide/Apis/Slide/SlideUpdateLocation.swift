import Foundation
import CoreLocation

struct SlideUpdateLocation: APICall {
    struct Location: Codable {
        var type = "Point"
        var coordinates: String
    }
    
    struct Response: Codable {
        let status: String
    }
    
    struct Request: Codable {
        let location: Location
    }
    
    init(_ coordinates: String){
        self.request = Request(location: Location(coordinates: coordinates))
    }
    
    var url = "http://10.0.0.40:3000/locate"
    var request: Request
    var method = APIMethod.POST
}


