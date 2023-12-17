
import Foundation
import SwiftProtobuf

protocol APICall {
    var url: String { get }
    var body: Data? { get }
    var method: APIMethod { get }
    var credentials: AppleCredentials { get }
    var queryParams: [URLQueryItem] { get }
    
    func pack() -> URLRequest
    func unpack<T>(_ payload: Data, type: T.Type) throws -> T
}

extension APICall {
    var data: Data? { nil }
    var queryParams: [URLQueryItem] { [] }
    var credentials: AppleCredentials {
        let appleCredentialsData = KeyChain.retrieve(key: "apple") ?? Data()
        let appleCredentials = try? JSONDecoder().decode(AppleCredentials.self, from: appleCredentialsData)
        
        return appleCredentials ?? AppleCredentials()
    }
        
    func pack() -> URLRequest {
        var urlComponents = URLComponents(string: url)!
        
        if !queryParams.isEmpty {
            urlComponents.queryItems = queryParams
        }
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        
        urlRequest.httpBody = body
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("Bearer \(credentials.identityToken ?? "")", forHTTPHeaderField: "Authorization")
        
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

struct HTTPClient {
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
    func fetch<T>(_ request: APICall) async throws -> T {
        let (data, response) = try await self.urlSession.data(for: request.pack())
            
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIError.fetchError
        }
        
        return try request.unpack(data, type: T.self)
    }
}

