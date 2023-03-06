
import Foundation


extension Encodable {
  func toDict() throws -> [String:String] {
    let data = try JSONEncoder().encode(self)
    
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:String] else {
        return [:]
    }
      
    return dictionary
  }
}

class JSON {
    class func toJSON(_ data: Data) throws -> Data {
        return try! JSONEncoder().encode(data)
    }

    class func fromJSON<T: Codable>(_ data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}



