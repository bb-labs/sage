
import Foundation

struct GoogleMapsEntities {
    struct OpeningHours: Codable {
        let openNow: String
    }
    
    struct Place: Codable {
        let name: String
        let rating: String
        let openingHours: OpeningHours
    }
    
    struct Address: Codable {
        let types: [String]
        let formattedAddress: String
    }
}
