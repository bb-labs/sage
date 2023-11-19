import Foundation

struct GoogleMapsAddress: APICall {
    struct Address: Codable {
        let types: [String]
        let formattedAddress: String
    }
    
    struct Request: Codable {
        let latlng: String
        var resultType: String?
        var locationType: String?
    }
    
    struct Response: Codable {
        let status: String
        let results: [Address]
    }
    
    init(latlng: String) {
        self.request = Request(latlng: latlng)
    }
    
    var url = "https://maps.googleapis.com/maps/api/geocode/json"
    var request: Request
    var method = APIMethod.GET
    var body: Data? { try! JSONEncoder().encode(request) }
    var queryParams: [URLQueryItem] {
        return [URLQueryItem(name: "latlng", value: request.latlng)]
    }
}
 
