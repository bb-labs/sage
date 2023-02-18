//
//  CameraModel.swift
//  Slide
//
//  Created by Truman Purnell on 2/18/23.
//

import Foundation
import AVFoundation

class CameraModel: NSObject, ObservableObject, AVCaptureFileOutputRecordingDelegate {
    @Published var session = AVCaptureSession()
    @Published var output = AVCaptureMovieFileOutput()
    
    var permissions = [AVMediaType.audio: false, AVMediaType.video: false]
    
    @Published var liveView: AVCaptureVideoPreviewLayer!
    
    @Published var captureView: AVPlayerLayer!
    @Published var captureViewLooper: AVPlayerLooper!
    @Published var captureURL: URL?
    @Published var showCapture = false
    @Published var isCapturing = false
    
    
    func requestPermissions() {
        self.requestPermission(.video)
        self.requestPermission(.audio)
    }
    
    func requestPermission(_ mediaType: AVMediaType) {
        if self.permissions[mediaType]! { return }
        
        AVCaptureDevice.requestAccess(for: mediaType) { status in
            self.permissions[mediaType] = status
            
            if self.permissions.values.allSatisfy({ $0 }) {
                self.setup()
            }
        }
    }
    
    func setup(){
        session.beginConfiguration()
        
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
        let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice)
        session.addInput(videoDeviceInput!)
        
        guard let audioDevice = AVCaptureDevice.default(for: .audio) else { return }
        let audioDeviceInput = try? AVCaptureDeviceInput(device: audioDevice)
        session.addInput(audioDeviceInput!)
        
        session.addOutput(output)
        session.commitConfiguration()
    }
    
    
    func startRecording(){
        isCapturing = true
        output.startRecording(
            to: URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(UUID().uuidString).mov"),
            recordingDelegate: self
        )
    }
    
    func stopRecording() {
          isCapturing = false
          output.stopRecording()
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        captureURL = outputFileURL
    }
}
