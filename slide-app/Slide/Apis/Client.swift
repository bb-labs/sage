
import Foundation

protocol APIRequest {
    func build(with credentials: Credentials?) -> URLRequest
    func unpack(_ payload: Data) throws -> any APIResponse
}

protocol APIResponse : Codable {}

enum ApiError: Error {
    case fetchError
}

struct HttpClient {
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    var credentials: Credentials?
        
    func fetch(_ request: APIRequest) async throws -> any APIResponse {
        let (data, response) = try await self.urlSession.data(for: request.build(with: self.credentials))
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw ApiError.fetchError
        }
        
        return try request.unpack(data)
    }
}

