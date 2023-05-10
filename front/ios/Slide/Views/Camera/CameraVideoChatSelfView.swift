
import SwiftUI
import WebRTC
import UIKit
import AVFoundation
import AVKit

struct CameraVideoChatSelfView: UIViewRepresentable {
    @EnvironmentObject var webRTCModel: WebRTCModel
        
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        webRTCModel.localVideoRender = RTCMTLVideoView(frame: view.frame)
        webRTCModel.localVideoRender?.transform = CGAffineTransformMakeScale(-1.0, 1.0)
        webRTCModel.localVideoRender?.videoContentMode = .scaleAspectFill
        webRTCModel.startCaptureLocalVideo()
        
        view.addSubview(webRTCModel.localVideoRender!)

        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
