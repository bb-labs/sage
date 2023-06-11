
import Foundation
import AVFoundation
import Combine
import SwiftUI
import UIKit
import CoreLocation

class UserModel: NSObject, ObservableObject {
    var user = User()
    var httpClient = HTTPClient()
    
    // Location info
    let locationManager = CLLocationManager()
    var coordinate: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestLocation()
    }
}
