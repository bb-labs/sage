
import CoreLocation

extension CLLocationCoordinate2D {
    func toString() -> String { "\(self.longitude),\(self.latitude)" }
}

class LocationModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    let httpClient = HttpClient()
    let locationManager = CLLocationManager()
    var coordinate: CLLocationCoordinate2D?

    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.requestPermission()
    }
    
    func requestPermission(){
        self.locationManager.requestAlwaysAuthorization()
    }

    func requestLocation() {
        self.locationManager.requestLocation()
    }
    
    func publishLocation() async {
        let slideLocationPush = SlideLocationPush.Request(
            userId: "truman",
            location: SlideLocationPush.Location(coordinates: self.coordinate!.toString()),
            credentialsDict: [:]
        )
        
        let slideLocationResponse = try? await self.httpClient.fetch(slideLocationPush) as? SlideLocationPush.Response
    }

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
}
