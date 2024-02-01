
import SwiftUI
import WebRTC
import UIKit
import AVFoundation
import AVKit

struct CameraVideoChatPeerView: UIViewRepresentable {
    @ObservedObject var webRTCModel: WebRTCModel
        
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        webRTCModel.remoteVideoRender = RTCMTLVideoView(frame: view.frame)
        webRTCModel.remoteVideoRender?.transform = CGAffineTransformMakeScale(-1.0, 1.0)
        
        view.addSubview(webRTCModel.remoteVideoRender!)

        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
