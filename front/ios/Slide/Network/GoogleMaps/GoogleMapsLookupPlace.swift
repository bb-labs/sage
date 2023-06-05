import Foundation

struct GoogleMapsLookupPlace: APICall {
    struct OpeningHours: Codable {
        let openNow: String
    }

    struct Place: Codable {
        let name: String
        let rating: String
        let openingHours: OpeningHours
    }
    
    struct Request: Codable {
        let input: String
    }
    
    struct Response: Codable {
        let status: String
        let candidates: [Place]
    }
    
    init(input: String) {
        self.request = Request(input: input)
    }
    
    var url = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json"
    var request: Request
    var method = APIMethod.GET
    var body: Data? { try! JSONEncoder().encode(request) }
    var queryParams: [URLQueryItem] {
        return [
            URLQueryItem(name: "input", value: request.input),
            URLQueryItem(name: "inputtype", value: "textquery"),
            URLQueryItem(name: "fields", value: "name,rating")
        ]
    }
}

