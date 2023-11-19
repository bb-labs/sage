import SwiftUI
import UIKit
import AVFoundation
import AVKit

struct CameraLiveView: UIViewRepresentable {
    @EnvironmentObject var cameraModel: CameraModel
        
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        cameraModel.liveView = AVCaptureVideoPreviewLayer(session: cameraModel.session)
        cameraModel.liveView.frame = view.frame
        cameraModel.liveView.videoGravity = .resizeAspectFill
        
        view.layer.addSublayer(cameraModel.liveView)
        
        DispatchQueue.global(qos: .background).async {
            cameraModel.session.startRunning()
        }
        
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
