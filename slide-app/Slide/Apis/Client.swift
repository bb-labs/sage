
import Foundation

typealias Credentials = [String:String]

protocol ApiRequest {
    func build(with credentials: Credentials?) -> URLRequest
    func unpack(_ payload: Data) throws -> any ApiResponse
}

protocol ApiResponse : Codable {
    associatedtype T
    var result: T? { get }
}

enum ApiError: Error {
    case fetchError
}

struct HttpClient {
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    var credentials: Credentials?
        
    func fetch(_ request: ApiRequest) async throws -> any ApiResponse {
        let (data, response) = try await self.urlSession.data(for: request.build(with: self.credentials))
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw ApiError.fetchError
        }
        
        return try request.unpack(data)
    }
}

