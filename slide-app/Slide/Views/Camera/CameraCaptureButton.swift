//
//  CameraCaptureButton.swift
//  Slide
//
//  Created by Truman Purnell on 2/18/23.
//

import SwiftUI

struct CameraCaptureButton: View {
    @EnvironmentObject var cameraModel: CameraModel
    
    @State var fill = 0.0
    @State var scale = 1.0
    @State var alreadyTapped = false
    
    let time = 5.0
    let size = 60.0
    let spring = 0.4
    let padding = 10.0
    let stroke = 4.0
    
    var body: some View {
        ZStack {
            Image(systemName: "camera.fill")
                .frame(width: size, height: size)
                .background(Color.blue)
                .mask(Circle())
                .foregroundColor(.white)
                .frame(width: size, height: size)
                .scaleEffect(scale)
            
            Circle()
                .trim(from: 0, to: fill)
                .stroke(.red, lineWidth: stroke)
                .frame(width: size * scale + padding , height: size * scale + padding)
                .rotationEffect(Angle(degrees: -90))
        }
        .padding(padding)
        .onTapGesture {
            if alreadyTapped { return }
            
            alreadyTapped = true
            
            cameraModel.startRecording()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                cameraModel.stopRecording()
            }

            withAnimation(.linear(duration: time)) {
                fill = 1
            }
            
            withAnimation(.spring(response: spring)) {
                scale = 1.25
            }
        }
    }
}
