import Foundation

struct SlidePresignData: APICall {    
    struct Request: Codable {
        let body: Data?
        let meta: SlidePresignUrl.Response
    }
    
    struct Response: Codable {
        let status: Int
    }
    
    init(body: Data?, meta: SlidePresignUrl.Response) {
        self.request = Request(body: body, meta: meta)
    }
    
    var request: Request
    var url: String { request.meta.url }
    var body: Data? { request.body }
    var method: APIMethod { request.meta.method }
}


