
import SwiftUI

struct CameraCaptureSettingsView: View {
    @EnvironmentObject var cameraModel: CameraModel
    @EnvironmentObject var userModel: UserModel
    
    var body: some View {
        HStack {
            Button {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    cameraModel.erase()
                }
            } label: {
                Text("👎")
                    .font(.system(size: 60))
                    .padding(.leading)
            }
            
            Spacer()
            
            Button {
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                
                let (name, data) = cameraModel.getVideoData()
                Task {
                    try await userModel.uploadProfileVideo(fileName: name, video: data!)
                }
            } label: {
                Text("👍")
                    .font(.system(size: 60))
                    .padding(.trailing)
            }
        }.padding()
        
    }
}
