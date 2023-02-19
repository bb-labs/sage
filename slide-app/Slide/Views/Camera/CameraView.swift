//
//  CameraView.swift
//  Slide
//
//  Created by Truman Purnell on 2/18/23.
//

import SwiftUI

struct CameraView: View {
    @EnvironmentObject var cameraModel: CameraModel
    
    var body: some View {
        ZStack {
            CameraLiveView()
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                Spacer()
                
                
                CameraCaptureButton()
            }
        }
        .overlay {
            if let url = cameraModel.captureURL {
                CameraCaptureView(url: url)
                    .ignoresSafeArea(.all, edges: .all)
            }
        }
        .onAppear {
            cameraModel.requestPermissions()
        }
    }
}
