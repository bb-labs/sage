
import Foundation
import CoreLocation


extension CLLocationCoordinate2D {
    func toString() -> String { "\(self.longitude),\(self.latitude)" }
}

extension UserModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.first?.coordinate {
            self.coordinate = coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get users location.")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("Changed auth status")
    }
    
    func publishLocation(_ latitude: Int32, _ longitude: Int32) async throws {
        let slideUpdateLocationRequest = SlideUpdateLocation( location: Location.with {
            $0.type = "Point"
            $0.latitude = latitude
            $0.longitude = longitude
        })
        
        let slideUpdateLocationResponse: SlideUpdateLocation.Response = try await self.httpClient.fetch(slideUpdateLocationRequest)
        
        print(slideUpdateLocationResponse)
    }
}
    
    
    
    

