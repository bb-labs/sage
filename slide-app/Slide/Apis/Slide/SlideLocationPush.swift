import Foundation
import CoreLocation

struct SlideLocationPush {
    struct Location: Encodable {
        let type = "Point"
        let coordinates: String
    }

    struct Request: APIRequest, Encodable {
        let location: Location
                
        func build(with credentials: Credentials?) -> URLRequest {
            let urlBuilder = URLBuilder(
                baseUrl: "http://10.0.0.40:3000/locate",
                queryParams: credentials
            )
            
            var urlRequest = URLRequest(url: urlBuilder.url)
            
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = try? JSONEncoder().encode(self)
            
            return urlRequest
        }
        
        func unpack(_ payload: Data) throws -> any APIResponse {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Response.self, from: payload)
        }
    }
    
    struct Response: APIResponse {
        let status: String
    }
}


