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
            Button { cameraModel.erase() } label: {
                Image(systemName: "trash.fill")
                    .frame(width: 40, height: 40)
                    .background(Color.blue)
                    .mask(Circle())
                    .foregroundColor(.white)
                    .padding(.leading)
            }
            Spacer()
            Button {
                let (name, data) = cameraModel.getVideoData()
                Task {
                    try await userModel.uploadProfileVideo(fileName: name, video: data!)
                }
            } label: {
                Image(systemName: "paperplane.fill")
                    .frame(width: 40, height: 40)
                    .background(Color.blue)
                    .mask(Circle())
                    .foregroundColor(.white)
                    .padding(.trailing)
            }
        }.padding()
        
    }
}
