//
//  SlideApp.swift
//  Slide
//
//  Created by Truman Purnell on 1/17/23.
//

import SwiftUI

@main
struct SlideApp: App {
    let userModel = UserModel()
    let cameraModel = CameraModel()
    let locationModel = LocationModel()
    let authModel = AuthModel()
    let introModel = IntroModel()
    
    var body: some Scene {
        WindowGroup {
            SlideView()
                .environmentObject(cameraModel)
                .environmentObject(locationModel)
                .environmentObject(userModel)
                .environmentObject(authModel)
                .environmentObject(introModel)
        }
    }
}
