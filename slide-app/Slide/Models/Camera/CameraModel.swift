
import Foundation
import AVFoundation
import SwiftUI

class CameraModel: NSObject, ObservableObject, AVCaptureFileOutputRecordingDelegate {
    @Published var captureURL: URL?
    @Published var session = AVCaptureSession()
    @Published var output = AVCaptureMovieFileOutput()
    
    var liveView: AVCaptureVideoPreviewLayer!
    var captureView: AVPlayerLayer!
    var captureViewLooper: AVPlayerLooper!
    var permissions = [AVMediaType.audio: false, AVMediaType.video: false]

    // Camera view settings
    var recordTime = 3.0
    @Published var isRecording = false
    @Published var isRecordingComplete = false
    
    
    func requestPermissions() {
        self.requestPermission(.video)
        self.requestPermission(.audio)
    }
    
    func requestPermission(_ mediaType: AVMediaType) {
        if self.permissions[mediaType]! { return }
        
        AVCaptureDevice.requestAccess(for: mediaType) { status in
            DispatchQueue.main.async {
                self.permissions[mediaType] = status
                
                if self.permissions.values.allSatisfy({ $0 }) {
                    self.setup()
                }
            }
        }
    }
    
    func setup(){
        session.beginConfiguration()
        
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
        let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice)
        
        //        guard let audioDevice = AVCaptureDevice.default(for: .audio) else { return }
        //        let audioDeviceInput = try? AVCaptureDeviceInput(device: audioDevice)
        //        session.addInput(audioDeviceInput!)
        
        session.addInput(videoDeviceInput!)

        session.addOutput(output)
        
        session.commitConfiguration()
    }
    
    func erase() {
        captureView = nil
        captureViewLooper = nil
        captureURL = nil
    }
    
    
    func startRecording(){
        output.startRecording(
            to: URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(UUID().uuidString).mov"),
            recordingDelegate: self
        )
    }
    
    func stopRecording() {
        output.stopRecording()
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        if output.recordedDuration.seconds < recordTime {
            return
        }
        
        withAnimation(.easeInOut(duration: 1.0)) {
            captureURL = outputFileURL
        }
    }
    
    func getVideoData() -> (String, Data?) {
        if let url = captureURL {
            return (
                url.lastPathComponent,
                try? Data(contentsOf: url, options: Data.ReadingOptions.alwaysMapped)
            )
        }
        
        return ("", nil)
    }
}
