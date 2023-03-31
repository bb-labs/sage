//
//  CameraCaptureButton.swift
//  Slide
//
//  Created by Truman Purnell on 2/18/23.
//

import SwiftUI

struct CameraCaptureButton: View {
    @EnvironmentObject var cameraModel: CameraModel
    
    @State var scale = 1.0
    @State var isAnimating = false
    @State var isComplete = false
    
    let time = 10.0
    let size = 70.0
    let padding = 20.0
    let stroke = 8.0
    
    var body: some View {
        ZStack {
            Image(systemName: "camera.fill")
                .frame(width: size, height: size)
                .background(Color("Main"))
                .mask(Circle())
                .foregroundColor(Color("Outline"))
                .scaleEffect(scale)
            
            Circle()
                .trim(from: 0, to: isAnimating ? 1 : 0)
                .stroke(Color("Background"), lineWidth: stroke)
                .frame(width: size * scale + padding , height: size * scale + padding)
                .rotationEffect(Angle(degrees: -90))
        }
        .padding(padding)
        .onLongPressGesture(minimumDuration: time, maximumDistance: .infinity) {
            isComplete = false
            isAnimating = false
            
//            cameraModel.stopRecording()
        } onPressingChanged: { isPressing in
            if isPressing {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()

                
//                cameraModel.startRecording()
                
                withAnimation(.spring(response: 0.5)) {
                    scale = 1.5
                }
                
                withAnimation(.linear(duration: time)) {
                    isAnimating = true
                }
            } else if !isComplete {
//                cameraModel.stopRecording()
                
                withAnimation(.easeInOut) {
                    isAnimating = false
                    scale = 1.0
                }
            }
        }
    }
}
