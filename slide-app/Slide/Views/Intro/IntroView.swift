import SwiftUI
import UIKit
import AVFoundation
import AVKit

struct IntroView: UIViewRepresentable {
    @EnvironmentObject var introModel: IntroModel

    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        if let fileURL = Bundle.main.url(forResource: "love", withExtension: "mp4") {
            let playerItem = AVPlayerItem(url: fileURL)
            let player = AVQueuePlayer(items: [playerItem])
        
            introModel.backgroundView = AVPlayerLayer(player: player)
            introModel.backgroundView.frame = view.frame
            introModel.backgroundView.videoGravity = .resizeAspectFill
            introModel.backgroundViewLooper = AVPlayerLooper(player: player, templateItem: playerItem)
            
            view.layer.addSublayer(introModel.backgroundView)
            
            player.isMuted = true
            
            player.play()
        }
        
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
