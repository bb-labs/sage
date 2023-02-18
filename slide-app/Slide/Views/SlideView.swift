
import SwiftUI
import CoreData
import CoreLocationUI

struct SlideView: View {
    @ObservedObject var cameraModel: CameraModel
    @ObservedObject var locationModel: LocationModel
    
    var body: some View {
        CameraView(cameraModel: cameraModel)
    }
}
