import Foundation
import CoreLocation

struct SlidePresignUrl: APICall {
    struct Request: Codable {
        let action: APIMethod
        let fileName: String
    }
    
    struct Response: Codable {
        let status: String
        let url: String
        let method: APIMethod
    }
    
    init(action: APIMethod, fileName: String) {
        self.request = Request(action: action, fileName: fileName)
    }
    
    var url = "http://10.0.0.40:3000/presign"
    var method = APIMethod.GET
    var request: Request
    var queryParams: [URLQueryItem] {
        return [
            URLQueryItem(name: "key", value: request.fileName),
            URLQueryItem(name: "action", value: request.action.rawValue),
        ]
    }
}


