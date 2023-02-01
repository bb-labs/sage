
import SwiftUI
import CoreData
import CoreLocationUI

struct SlideView: View {
    @ObservedObject var locationModel: LocationModel
    
    var body: some View {
        VStack {
            if let address = locationModel.address {
                Text(address)
            }

            LocationButton {
                locationModel.requestLocation()
            }
        }
    }
}
