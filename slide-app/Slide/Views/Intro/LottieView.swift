
import SwiftUI
import Foundation
import Lottie

struct LottieView: UIViewRepresentable {
    @Binding var gif: LottieAnimationView
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        
        view.backgroundColor = .clear
        
        gif.loopMode = .loop
        gif.backgroundColor = .clear
        gif.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(gif)
        view.addConstraints([
            gif.widthAnchor.constraint(equalTo: view.widthAnchor),
            gif.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
