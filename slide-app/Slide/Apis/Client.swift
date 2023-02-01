
import Foundation

protocol ApiRequest {
    var urlRequest: URLRequest { get }
    func unpack(_ payload: Data) throws -> any ApiResponse
}

protocol ApiResponse : Codable {
    associatedtype T
    var result: T? { get }
}

enum ApiError: Error {
    case fetchError
}

class HttpClient {
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
    func fetch(_ request: ApiRequest) async throws -> any ApiResponse {
        let (data, response) = try await self.urlSession.data(for: request.urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw ApiError.fetchError
        }
        
        return try request.unpack(data)
    }
}

