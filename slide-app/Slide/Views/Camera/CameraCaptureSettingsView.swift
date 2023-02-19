//
//  CameraView.swift
//  Slide
//
//  Created by Truman Purnell on 2/18/23.
//

import SwiftUI

struct CameraCaptureSettingsView: View {
    @EnvironmentObject var cameraModel: CameraModel
    
    var body: some View {
        Button { cameraModel.erase() } label: {
            Image(systemName: "trash.fill")
                .frame(width: 40, height: 40)
                .background(Color.blue)
                .mask(Circle())
                .foregroundColor(.white)
                .padding(.leading)
        }
    }
}
