
import Foundation

struct GoogleMapsAddress {
    struct Response: ApiResponse {
        typealias T = GoogleMapsEntities.Address
        
        let status: String
        let results: [T]
        
        var result: GoogleMapsEntities.Address? {
            return self.results.first
        }
    }

    struct Request: ApiRequest {
        let latlng: String
        var resultType: String?
        var locationType: String?
        
        var urlRequest: URLRequest {
            var urlRequest = URLRequest(url: URLBuilder(baseUrl: "https://maps.googleapis.com/maps/api/geocode/json")
                .addQueryParam(key: "latlng", value: self.latlng)
                .addQueryParam(key: "key", value: "AIzaSyAruGKwktB8dk7N5-MD4BVVeOqhuaSxcU8")
                .url)
            
            urlRequest.httpMethod = "GET"
            
            return urlRequest
        }
        
        func unpack(_ payload: Data) throws -> any ApiResponse {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Response.self, from: payload)
        }
    }
}

