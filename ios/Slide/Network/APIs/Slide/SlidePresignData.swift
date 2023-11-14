import Foundation

struct SlidePresignData: APICall {
    var data: Data
    let meta: PresignedUrlResponse
    
    var url: String { meta.url }
    var body: Data? { data }
    var method: APIMethod { APIMethod(rawValue: meta.request.action)! }
    
    struct Response: Codable {
        let status: Int
    }
}


