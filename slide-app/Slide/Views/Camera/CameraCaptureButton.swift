//
//  CameraCaptureButton.swift
//  Slide
//
//  Created by Truman Purnell on 2/18/23.
//

import SwiftUI

struct CameraCaptureButton: View {
    @GestureState var isPressing = false
    
    let size = 60.0
    let spring = 0.4
    let padding = 10.0
    let stroke = 4.0
        
    var scale: CGFloat { isPressing ? 1.5 : 1.0 }
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 10, maximumDistance: CGFloat.greatestFiniteMagnitude)
            .updating($isPressing) { currentState, gestureState, transaction in
                gestureState = currentState
            }
            .onEnded { finished in
                
            }
    }
    
    
    
    
    var body: some View {
        ZStack {
            Image(systemName: "camera.fill")
               .foregroundColor(.blue)
               .frame(width: size, height: size)
               .background(.white)
               .mask(Circle())
               .padding(padding)
               .scaleEffect(scale)
               .animation(.spring(response: spring), value: scale)
               .gesture(longPress)
        }
    }
}
