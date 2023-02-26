import Foundation
import CoreLocation

struct SlideCreateUser {
    struct User: Encodable {
        
    }
    
    struct Request: ApiRequest, Encodable {
        let user: User
        var authorization: [String:String]
        
        func build(with credentials: Credentials?) -> URLRequest {
            let urlBuilder = URLBuilder(
                baseUrl: "http://10.0.0.40:3000/user",
                queryParams: credentials
            )
            
            var urlRequest = URLRequest(url: urlBuilder.url)
            
            urlRequest.httpMethod = "POST"
            
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


