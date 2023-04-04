//
//  CameraView.swift
//  Slide
//
//  Created by Truman Purnell on 2/18/23.
//

import SwiftUI

struct CameraCaptureSettingsView: View {
    @EnvironmentObject var cameraModel: CameraModel
    @EnvironmentObject var userModel: UserModel
    
    var body: some View {
        HStack {
            Button {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    cameraModel.erase()
                }
            } label: {
                Text("👎")
                    .font(.system(size: 60))
                    .padding(.leading)
            }
            Spacer()
            Button {
                let (name, data) = cameraModel.getVideoData()
                Task {
                    try await userModel.uploadProfileVideo(fileName: name, video: data!)
                }
            } label: {
                Text("👍")
                    .font(.system(size: 60))
                    .padding(.trailing)
            }
        }.padding()
        
    }
}
