
import SwiftUI

struct SlideView: View {
    @EnvironmentObject var cameraModel: CameraModel
    
    var body: some View {
        CameraVideoChatView()
    }
}
