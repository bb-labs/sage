//
//  SlideApp.swift
//  Slide
//
//  Created by Truman Purnell on 1/17/23.
//

import SwiftUI

@main
struct SlideApp: App {
    let cameraModel = CameraModel()
    let locationModel = LocationModel()

    var body: some Scene {
        WindowGroup {
            SlideView()
                .environmentObject(cameraModel)
                .environmentObject(locationModel)
        }
    }
}
