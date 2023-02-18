//
//  CameraView.swift
//  Slide
//
//  Created by Truman Purnell on 2/18/23.
//

import SwiftUI

struct CameraView: View {
    @ObservedObject var cameraModel: CameraModel
    
    var body: some View {
        ZStack {
            
            Color
                .black
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                Spacer()
                
                HStack {
                    CameraCaptureButton() {
                        print("whoa")
                    }
                }
            }
        }.onAppear {
            cameraModel.requestPermissions()
        }
    }
}
