
import Foundation
import WebRTC

class WebRTCModel: NSObject, ObservableObject {
    let streamId = "sage-stream"
    let recipient: User
    let signalingClient = WSSClient()
    
    public static let peerFactory: RTCPeerConnectionFactory = {
        RTCInitializeSSL()
        let videoEncoderFactory = RTCDefaultVideoEncoderFactory()
        let videoDecoderFactory = RTCDefaultVideoDecoderFactory()
        return RTCPeerConnectionFactory(encoderFactory: videoEncoderFactory, decoderFactory: videoDecoderFactory)
    }()
    
    public let peerConnection: RTCPeerConnection
    public let rtcAudioSession =  RTCAudioSession.sharedInstance()
    public let audioQueue = DispatchQueue(label: "audio")
    public let mediaConstrains = [kRTCMediaConstraintsOfferToReceiveAudio: kRTCMediaConstraintsValueTrue,
                                   kRTCMediaConstraintsOfferToReceiveVideo: kRTCMediaConstraintsValueTrue]
    public var videoCapturer: RTCVideoCapturer?
    public var localVideoTrack: RTCVideoTrack?
    public var remoteVideoTrack: RTCVideoTrack?
    public var localDataChannel: RTCDataChannel?
    public var remoteDataChannel: RTCDataChannel?
    
    public var localVideoRender: RTCMTLVideoView?
    public var remoteVideoRender: RTCMTLVideoView?
    
    init(_ user: User) {
        // Config setup
        let config = RTCConfiguration()
        config.iceServers = [RTCIceServer(urlStrings: ["stun:stun.l.google.com:19302",
                                                       "stun:stun1.l.google.com:19302",
                                                       "stun:stun2.l.google.com:19302",
                                                       "stun:stun3.l.google.com:19302",
                                                       "stun:stun4.l.google.com:19302"])]
        config.sdpSemantics = .unifiedPlan
        config.continualGatheringPolicy = .gatherContinually
        
        // Create peer connection
        guard let peerConnection = WebRTCModel.peerFactory.peerConnection(
            with: config,
            constraints: RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: [:]),
            delegate: nil
        ) else {
            fatalError("Could not create new RTCPeerConnection")
        }
        
        self.recipient = user
        self.peerConnection = peerConnection
        super.init()
        self.peerConnection.delegate = self
        
        // Starting listening
        self.listen()
        
        
        // Audio
        let audioConstraints = RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil)
        let audioSource = WebRTCModel.peerFactory.audioSource(with: audioConstraints)
        let audioTrack = WebRTCModel.peerFactory.audioTrack(with: audioSource, trackId: "audio0")
        self.peerConnection.add(audioTrack, streamIds: [streamId])

        self.rtcAudioSession.lockForConfiguration()
        do {
            try self.rtcAudioSession.setCategory(AVAudioSession.Category.playAndRecord.rawValue)
            try self.rtcAudioSession.setMode(AVAudioSession.Mode.voiceChat.rawValue)
        } catch let error {
            fatalError("Error changing AVAudioSession category: \(error)")
        }
        self.rtcAudioSession.unlockForConfiguration()

        // Video
        let videoSource = WebRTCModel.peerFactory.videoSource()
        self.videoCapturer = RTCCameraVideoCapturer(delegate: videoSource)
        let videoTrack = WebRTCModel.peerFactory.videoTrack(with: videoSource, trackId: "video0")
        self.localVideoTrack = videoTrack
        self.peerConnection.add(videoTrack, streamIds: [streamId])
        self.remoteVideoTrack = self.peerConnection.transceivers.first { $0.mediaType == .video }?.receiver.track as? RTCVideoTrack

        // Data
        guard let dataChannel = self.peerConnection.dataChannel(forLabel: "WebRTCData", configuration: RTCDataChannelConfiguration()) else {
            debugPrint("Warning: Couldn't create data channel.")
            return
        }
        self.localDataChannel = dataChannel
    }
}
