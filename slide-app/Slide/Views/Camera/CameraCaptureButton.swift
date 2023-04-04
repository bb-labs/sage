
import SwiftUI

struct CameraCaptureButton: View {
    @EnvironmentObject var cameraModel: CameraModel
    
    @State var scale = 1.0
    
    let size = 70.0
    let padding = 20.0
    let stroke = 8.0
    let spring = 0.5
    let finalSpring = 1.5
    
    var body: some View {
        ZStack {
            Image(systemName: cameraModel.isRecordingComplete ? "checkmark.circle.fill" :  "camera.fill")
                .frame(width: size, height: size)
                .background(Color("Main"))
                .mask(Circle())
                .foregroundColor(Color("Outline"))
                .scaleEffect(scale)
            
            Circle()
                .trim(from: 0, to: cameraModel.isRecording ? 1 : 0)
                .stroke(Color("Background"), lineWidth: stroke)
                .frame(width: size * scale + padding , height: size * scale + padding)
                .rotationEffect(Angle(degrees: -90))
        }
        .padding(padding)
        .onLongPressGesture(minimumDuration: cameraModel.recordTime, maximumDistance: .infinity) {
            cameraModel.stopRecording()
            
            cameraModel.isRecordingComplete = true
            
            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
        } onPressingChanged: { isPressing in
            if isPressing {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                
                cameraModel.startRecording()
                
                withAnimation(.spring(response: spring)) {
                    scale = finalSpring
                }
                
                withAnimation(.linear(duration: cameraModel.recordTime)) {
                    cameraModel.isRecording = true
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    if !cameraModel.isRecordingComplete {
                        cameraModel.stopRecording()
                        
                        withAnimation(.easeInOut) {
                            cameraModel.isRecording = false
                            scale = 1.0
                        }
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            cameraModel.isRecordingComplete = false
                            cameraModel.isRecording = false
                            scale = 1.0
                        }
                    }
                }
            }
        }
    }
}
