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
    
    let size = 60.0
    let spring = 0.4
    let padding = 10.0
    let stroke = 4.0
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
                .frame(width: size, height: size)
                .scaleEffect(scale)
            
            Circle()
                .trim(from: 0, to: fill)
                .stroke(.red, lineWidth: 5)
                .frame(width: size * scale + padding , height: size * scale + padding)
                .rotationEffect(Angle(degrees: -90))
        }
        .padding(padding)
        .onTapGesture {
            withAnimation(.linear(duration: 5)) {
                fill = 1
            }
            
            withAnimation(.spring(response: spring)) {
                scale = 1.25
            }
        }
    }
}
