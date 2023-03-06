import Foundation
import CoreLocation

struct SlidePresignData {
    struct Request: APIRequest, Encodable {
        let body: Data?
        let url: String
        let method: String
        
        func build(with credentials: Credentials?) -> URLRequest {
            let urlBuilder = URLBuilder(baseUrl: url, queryParams: credentials)
            
            var urlRequest = URLRequest(url: urlBuilder.url)
            
            urlRequest.httpMethod = method
            
            if let body = body {
                urlRequest.httpBody = body
            }
            
            return urlRequest
        }
        
        func unpack(_ payload: Data) throws -> any APIResponse {
            if(payload.isEmpty) {
                return Response(status: 200)
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Response.self, from: payload)
        }
    }
    
    struct Response: APIResponse {
        let status: Int
    }
}


