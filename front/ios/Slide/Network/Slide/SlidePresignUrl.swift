import Foundation
import CoreLocation

struct SlidePresignUrl: APICall {
    var presignInfo: PresignedUrlRequest
        
    var url = "http://10.0.0.40:3000/presign"
    var method = APIMethod.GET
    var body: Data? { try! presignInfo.serializedData() }
    var queryParams: [URLQueryItem] {
        return [
            URLQueryItem(name: "key", value: presignInfo.fileName),
            URLQueryItem(name: "action", value: presignInfo.action),
        ]
    }
}


