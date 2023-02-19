
import SwiftUI

struct CameraView: View {
    @EnvironmentObject var cameraModel: CameraModel
    
    var body: some View {
        ZStack {
            CameraLiveView()
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                Spacer()
                CameraCaptureButton()
            }
        }
        .overlay {
            if let url = cameraModel.captureURL {
                CameraCaptureView(url: url)
                    .ignoresSafeArea(.all, edges: .all)
                    .overlay(alignment: .bottom) {
                        CameraCaptureSettingsView()
                    }
            }
        }
        .onAppear {
            cameraModel.requestPermissions()
        }
    }
}
