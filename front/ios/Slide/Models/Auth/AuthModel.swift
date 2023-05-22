
import Foundation

protocol Credentials: Codable {}

extension Credentials {
    var data: Data {
        guard let data = try? JSONEncoder().encode(self) else { return Data() }
        
        return data
    }
    
    var dict: [String:String] {
        guard let dict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return [:] }
        
        return dict as! [String:String]
    }
    
    var queryParams: [URLQueryItem] {
        self.dict.reduce(into: []) { params, param in
            params.append(URLQueryItem(name: param.key, value: param.value))
        }
    }
}

class AuthModel: ObservableObject {
    var client = HttpClient()
}


