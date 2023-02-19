
import Foundation
import CoreLocation

struct SlidePresignUrl {
    struct Request: ApiRequest, Encodable {
        let action: String
        let fileName: String
        
        var urlRequest: URLRequest {
            var urlRequest = URLRequest(url: URLBuilder(
                baseUrl: "http://10.0.0.40:3000/presign",
                queryParams: ["action": action, "key": fileName]
            ).url)
            
            urlRequest.httpMethod = "GET"
            
            return urlRequest
        }
        
        func unpack(_ payload: Data) throws -> any ApiResponse {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Response.self, from: payload)
        }
    }
    
    struct Response: ApiResponse {
        typealias T = Response
        
        let status: String
        let url: String
        let method: String
        
        var result: T? {
            return self
        }
    }
}


