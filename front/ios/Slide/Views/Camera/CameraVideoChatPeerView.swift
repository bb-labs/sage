
import SwiftUI
import WebRTC
import UIKit
import AVFoundation
import AVKit

struct CameraVideoChatPeerView: UIViewRepresentable {
    @EnvironmentObject var webRTCModel: WebRTCModel
        
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        webRTCModel.remoteVideoRender = RTCMTLVideoView(frame: view.frame)

        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
