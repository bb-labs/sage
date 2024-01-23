

import Foundation
import WebRTC

extension WebRTCModel: RTCDataChannelDelegate {
    func startCaptureLocalVideo() {
        guard let capturer = self.videoCapturer as? RTCCameraVideoCapturer else {
            return
        }

       guard
           let frontCamera = (RTCCameraVideoCapturer.captureDevices().first { $0.position == .front }),
       
           // choose highest res
           let format = (RTCCameraVideoCapturer.supportedFormats(for: frontCamera).sorted { (f1, f2) -> Bool in
               let width1 = CMVideoFormatDescriptionGetDimensions(f1.formatDescription).width
               let width2 = CMVideoFormatDescriptionGetDimensions(f2.formatDescription).width
               return width1 < width2
           }).last,
       
           // choose highest fps
           let fps = (format.videoSupportedFrameRateRanges.sorted { return $0.maxFrameRate < $1.maxFrameRate }.last) else {
           return
       }

       capturer.startCapture(with: frontCamera,
                             format: format,
                             fps: Int(fps.maxFrameRate))
       
        self.localVideoTrack?.add(self.localVideoRender!)
    }
    
    func renderRemoteVideo() {
        self.remoteVideoTrack?.add(self.remoteVideoRender!)
    }
    
    func sendData(_ data: Data) {
        let buffer = RTCDataBuffer(data: data, isBinary: true)
        self.remoteDataChannel?.sendData(buffer)
    }
    
    func setTrackEnabled<T: RTCMediaStreamTrack>(_ type: T.Type, isEnabled: Bool) {
        peerConnection.transceivers
            .compactMap { return $0.sender.track as? T }
            .forEach { $0.isEnabled = isEnabled }
    }
    
    func dataChannelDidChangeState(_ dataChannel: RTCDataChannel) {
        debugPrint("dataChannel did change state: \(dataChannel.readyState)")
    }
    
    func dataChannel(_ dataChannel: RTCDataChannel, didReceiveMessageWith buffer: RTCDataBuffer) {
        print("Got data from peer: ", buffer)
    }
}
