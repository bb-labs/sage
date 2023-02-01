
import Foundation
import CoreLocation

struct SlideLocationPush {
    struct Request: ApiRequest, Encodable {
        let userId: String
        let coordinate: String
        
        var urlRequest: URLRequest {
            var urlRequest = URLRequest(url: URLBuilder(baseUrl: "http://10.0.0.40:3000/locate").url)
            
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = try? JSONEncoder().encode(self)
            
            return urlRequest
        }
        
        func unpack(_ payload: Data) throws -> any ApiResponse {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Response.self, from: payload)
        }
    }
    
    struct Response: ApiResponse {
        typealias T = String
        
        let status: String
        
        var result: T? {
            return self.status
        }
    }
}


