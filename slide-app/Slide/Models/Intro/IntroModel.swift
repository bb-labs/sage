
import Foundation
import AVFoundation

class IntroModel: NSObject, ObservableObject {
    @Published var backgroundView: AVPlayerLayer!
    @Published var backgroundViewLooper: AVPlayerLooper!
    
}
