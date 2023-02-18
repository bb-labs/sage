//
//  CameraCaptureButton.swift
//  Slide
//
//  Created by Truman Purnell on 2/18/23.
//

import SwiftUI

struct CameraCaptureButton: View {
    var action: (() -> Void)
    var body: some View {
        let size = 60.0
        Button(action: action, label: {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: size, height: size)
                
                Circle()
                    .stroke(Color.white, lineWidth: 2)
                    .frame(width: size+5, height: size+5)
            }
        })
    }
}

