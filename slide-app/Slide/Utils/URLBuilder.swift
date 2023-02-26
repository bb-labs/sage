
import Foundation

struct URLBuilder {
    let baseUrl: String
    var queryParams: [String:String]
    
    init(baseUrl: String, queryParams: [String:String]?){
        self.baseUrl = baseUrl
        self.queryParams = queryParams != nil ? queryParams! : [:]
    }
    
    func addQueryParam(key: String, value: String) -> URLBuilder {
        var newQueryParams = self.queryParams
        newQueryParams[key] = value
        
        return URLBuilder(baseUrl: self.baseUrl, queryParams: newQueryParams)
    }
    
    var url: URL {
        var components = URLComponents(string: self.baseUrl)!
        
        if !self.queryParams.isEmpty {
            components.queryItems = self.queryParams.reduce(into: []) { params, param in
                params.append(URLQueryItem(name: param.key, value: param.value))
            }
        }
        

        return components.url!
    }
}
