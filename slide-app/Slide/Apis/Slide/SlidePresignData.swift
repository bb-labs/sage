import Foundation

struct SlidePresignData: APICall {
    struct Request: Codable {
        let body: Data?
        let url: String
        let method: APIMethod
    }
    
    struct Response: Codable {
        let status: Int
    }
    
    init(body: Data?, url: String, method: APIMethod) {
        self.request = Request(body: body, url: url, method: method)
    }
    
    var request: Request
    var url: String { request.url }
    var body: Data? { request.body }
    var method: APIMethod { request.method }
}


