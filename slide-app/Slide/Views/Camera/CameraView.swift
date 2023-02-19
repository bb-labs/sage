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
                
                HStack {
                    CameraCaptureButton()
                }
            }
        }.onAppear {
            cameraModel.requestPermissions()
        }
    }
}
