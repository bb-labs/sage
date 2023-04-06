
import SwiftUI

struct CameraView: View {
    @EnvironmentObject var cameraModel: CameraModel
    @EnvironmentObject var userModel: UserModel
    
    @State var showingExplanations = true
    
    var body: some View {
        ZStack {
            CameraLiveView()
                .ignoresSafeArea(.all, edges: .all)
                .opacity(showingExplanations ? 0.5 : 1)
                .background(showingExplanations ? .black : .clear)
                .overlay {
                    if showingExplanations {
                        CameraExplanationView()
                    }
                }
                .gesture(DragGesture().onEnded { _ in
                    withAnimation(.easeInOut(duration: 1.0)) {
                        self.showingExplanations = false
                    }
                })
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        self.showingExplanations = false
                    }
                }
            
            if !showingExplanations {
                VStack {
                    Spacer()
                    
                    CameraCaptureButton()
                }
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
