
import Foundation

protocol APICall {
    associatedtype Request: Codable
    associatedtype Response: Codable
    
    var body: Data? { get }
    var url: String { get }
    var request: Request { get }
    var method: APIMethod { get }
    var queryParams: [URLQueryItem] { get }
    
    func pack(with credentials: Credentials?) -> URLRequest
    func unpack<T: Codable>(_ payload: Data) throws -> T
}

extension APICall {
    var body: Data? {
        try! JSONEncoder().encode(request)
    }
    
    var queryParams: [URLQueryItem] { [] }
        
    func pack(with credentials: Credentials?) -> URLRequest {
        var urlComponents = URLComponents(string: url)!
        
        urlComponents.queryItems = queryParams
        
        if let credentials = credentials {
            urlComponents.queryItems! += credentials.queryParams
        }
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        
        urlRequest.httpBody = body
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
    func unpack<T: Codable>(_ payload: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: payload)
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
    var credentials: Credentials?
        
    func fetch<T: Codable>(_ request: any APICall) async throws -> T {
        let (data, response) = try await self.urlSession.data(for: request.pack(with: self.credentials))
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIError.fetchError
        }
        
        return try request.unpack(data)
    }
}

