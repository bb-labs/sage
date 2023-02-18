import SwiftUI
import UIKit
import AVFoundation
import AVKit

struct CameraCaptureView: UIViewRepresentable {
    @EnvironmentObject var cameraModel: CameraModel

    var url: URL
    var size: CGSize
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        
        print(url)
        let playerItem = AVPlayerItem(url: url)
        let player = AVQueuePlayer(items: [playerItem])
    
        cameraModel.captureView = AVPlayerLayer(player: player)
        cameraModel.captureView.frame.size = size
        cameraModel.captureView.videoGravity = .resizeAspectFill
        cameraModel.captureViewLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        
        view.layer.addSublayer(cameraModel.captureView)
        
        player.play()
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
