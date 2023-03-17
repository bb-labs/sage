
import Foundation
import AVFoundation
import SwiftUI
import Lottie

struct WelcomeCard: Identifiable, Equatable {
    var id: Int
    var title: String
    var description: String
    var gif: LottieAnimationView = .init()
}

class IntroModel: NSObject, ObservableObject {
    @Published var backgroundView: AVPlayerLayer!
    @Published var backgroundViewLooper: AVPlayerLooper!
    
    var cardIndex = 0
    var cards: [WelcomeCard] = [
        .init(
            id: 0,
            title: "Authentic Experience",
            description: "Ditch the elaborate profile, the fabricated images and that blurb you spent an hour and a half writing. Upload a video of yourself every 24 hours. That's it!",
            gif: .init(name: "authentic", bundle: .main)
        ),
        .init(
            id: 1,
            title: "No Ghosting",
            description: "We hate ghosting. In fact, that's why we call ourselves Sage; it keeps the ghosts away! Each time you bail on a match, you lose a ghost. Lose them all, we ghost you!",
            gif:.init(name: "ghost", bundle: .main)
        ),
        .init(
            id: 2,
            title: "We Handle the Date",
            description: "Ready to take the next step? Sage handles it: time, place, everything. You just have to show up, or lose a ghost!",
            gif: .init(name: "schedule", bundle: .main)
        ),
    ]
}


