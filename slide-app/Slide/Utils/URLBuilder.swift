
import Foundation

struct URLBuilder {
    let baseUrl: String
    var queryParams: [String:String] = [:]
    
    func addQueryParam(key: String, value: String) -> URLBuilder {
        var newQueryParams = self.queryParams
        newQueryParams[key] = value
        
        return URLBuilder(baseUrl: self.baseUrl, queryParams: newQueryParams)
    }
    
    var url: URL {
        var components = URLComponents(string: self.baseUrl)!
        
        components.queryItems = self.queryParams.reduce(into: []) { params, param in
            params.append(URLQueryItem(name: param.key, value: param.value))
        }

        return components.url!
    }
}
