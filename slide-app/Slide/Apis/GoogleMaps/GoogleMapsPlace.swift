
import Foundation

struct GoogleMapsPlaceRequest: ApiRequest {
    let input: String
    var inputtype: String = "textquery"
    
    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: URLBuilder(baseUrl: "https://maps.googleapis.com/maps/api/place/findplacefromtext/json")
            .addQueryParam(key: "input", value: "99 S Broadway Suite 115, Denver, CO 80209")
            .addQueryParam(key: "inputtype", value: self.inputtype)
            .addQueryParam(key: "fields", value: "name,rating")
            .addQueryParam(key: "key", value: "AIzaSyAruGKwktB8dk7N5-MD4BVVeOqhuaSxcU8")
            .url)
        
        urlRequest.httpMethod = "GET"
        
        return urlRequest
    }
    
    func unpack(_ payload: Data) throws -> any ApiResponse {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(GoogleMapsPlaceResponse.self, from: payload)
    }
}

struct GoogleMapsPlaceResponse: ApiResponse {
    typealias T = GoogleMapsEntities.Place
    
    let status: String
    let candidates: [T]
    
    var result: T? {
        return self.candidates.first
    }
}

