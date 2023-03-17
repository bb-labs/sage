
import SwiftUI
import Foundation

struct LottieView: UIViewRepresentable {
    @Binding var card: WelcomeCard
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        
        view.backgroundColor = .clear
        
        card.gif.loopMode = .loop
        card.gif.backgroundColor = .clear
        card.gif.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(card.gif)
        view.addConstraints([
            card.gif.widthAnchor.constraint(equalTo: view.widthAnchor),
            card.gif.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
