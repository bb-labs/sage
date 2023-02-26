import Foundation

struct GoogleMapsAddress {
    struct Address: Codable {
        let types: [String]
        let formattedAddress: String
    }
    
    struct Request: ApiRequest {
        let latlng: String
        var resultType: String?
        var locationType: String?
        
        func build(with credentials: Credentials?) -> URLRequest {
            let urlBuilder = URLBuilder(baseUrl: "https://maps.googleapis.com/maps/api/geocode/json", queryParams: credentials)
                .addQueryParam(key: "latlng", value: self.latlng)

            var urlRequest = URLRequest(url: urlBuilder.url)
            
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
        typealias T = Address
        
        let status: String
        let results: [T]
        
        var result: Address? {
            return self.results.first
        }
    }
}

