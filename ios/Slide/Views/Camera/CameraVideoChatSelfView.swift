
import SwiftUI
import WebRTC
import UIKit
import AVFoundation
import AVKit

struct CameraVideoChatSelfView: UIViewRepresentable {
    @EnvironmentObject var webRTCModel: WebRTCModel
        
    func makeUIView(context: Context) -> some UIView {
        let bounds = UIScreen.main.bounds
        let view = UIView(frame: CGRect(x: bounds.width * 0.6, y: bounds.height * 0.65, width: bounds.width / 4, height: bounds.height / 4))
        
        webRTCModel.localVideoRender = RTCMTLVideoView(frame: view.frame)
        webRTCModel.localVideoRender?.transform = CGAffineTransformMakeScale(-1.0, 1.0)
        webRTCModel.startCaptureLocalVideo()
        
        view.addSubview(webRTCModel.localVideoRender!)

        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
