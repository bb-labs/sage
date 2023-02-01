
import CoreLocation

extension CLLocationCoordinate2D {
    func toString() -> String { "\(self.latitude),\(self.longitude)" }
}

class LocationModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    let httpClient = HttpClient()
    let locationManager = CLLocationManager()
    
    var coordinate: CLLocationCoordinate2D?
    @Published var address: String?

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

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.first?.coordinate {
            self.coordinate = coordinate
            Task {
                let addressRequest = GoogleMapsAddress.Request(latlng: coordinate.toString())
                let addressResponse = try await self.httpClient.fetch(addressRequest) as! GoogleMapsAddress.Response
                
                print(addressResponse.result!.formattedAddress)
//                let place = try await self.googleMapsApi.fetch(GoogleMapsPlace(input: address.result!))
//                print(place.result)
//                let place = try await self.googleMapsApi.fetch(GoogleMapsPlace(address))
                
                await MainActor.run {
//                    self.place = place
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get users location.")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("Changed auth status")
    }
}
