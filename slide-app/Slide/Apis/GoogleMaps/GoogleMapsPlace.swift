import Foundation

struct GoogleMapsPlace{
    struct OpeningHours: Codable {
        let openNow: String
    }

    struct Place: Codable {
        let name: String
        let rating: String
        let openingHours: OpeningHours
    }
    
    struct Request: ApiRequest {
        let input: String
        var inputtype: String = "textquery"
        
        func build(with credentials: Credentials?) -> URLRequest {
            let urlBuilder = URLBuilder(baseUrl: "https://maps.googleapis.com/maps/api/place/findplacefromtext/json", queryParams: credentials)
                .addQueryParam(key: "input", value: "99 S Broadway Suite 115, Denver, CO 80209")
                .addQueryParam(key: "inputtype", value: self.inputtype)
                .addQueryParam(key: "fields", value: "name,rating")
            
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
        typealias T = Place
        
        let status: String
        let candidates: [T]
        
        var result: T? {
            return self.candidates.first
        }
    }
}

