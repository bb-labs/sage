
import Foundation
import SwiftProtobuf

protocol APICall {
    var url: String { get }
    var body: Data? { get }
    var method: APIMethod { get }
    var queryParams: [URLQueryItem] { get }
    
    func pack(with credentials: [Credentials]) -> URLRequest
    func unpack<T>(_ payload: Data, type: T.Type) throws -> T
}

extension APICall {
    var data: Data? { nil }
    var queryParams: [URLQueryItem] { [] }
        
    func pack(with credentials: [Credentials]) -> URLRequest {
        var urlComponents = URLComponents(string: url)!
        
        urlComponents.queryItems = queryParams
        
        for credential in credentials {
            urlComponents.queryItems! += credential.queryParams
        }
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        
        urlRequest.httpBody = body
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
    func unpack<T>(_ payload: Data, type: T.Type) throws -> T {
        switch T.self {
        case let decodableType as Decodable.Type:
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(decodableType, from: payload) as! T
        case let protobufType as SwiftProtobuf.Message.Type:
            return try protobufType.init(serializedData: payload) as! T
        default:
            throw APIError.fetchError
        }
    }
}

enum APIError: Error {
    case fetchError
}

enum APIMethod: String, Codable {
    case GET = "GET"
    case PUT = "PUT"
    case POST = "POST"
}

struct HttpClient {
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    var credentials: [Credentials] = []
    
    func fetch<T>(_ request: APICall) async throws -> T {
        let (data, response) = try await self.urlSession.data(for: request.pack(with: self.credentials))
            
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIError.fetchError
        }
        
        return try request.unpack(data, type: T.self)
    }
}

