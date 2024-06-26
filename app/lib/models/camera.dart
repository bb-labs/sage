import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

class CameraModel with ChangeNotifier {
  XFile _recording = XFile('');
  XFile get recording => _recording;
  set recording(XFile value) {
    _recording = value;
    notifyListeners();
  }

  late List<CameraDescription> _cameras;
  List<CameraDescription> get cameras => _cameras;

  late CameraController _cameraController;
  CameraController get cameraController => _cameraController;

  late VideoPlayerController _playerController;
  VideoPlayerController get playerController => _playerController;

  init() async {
    _cameras = await availableCameras();
    final frontCamera = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);

    _cameraController = CameraController(frontCamera, ResolutionPreset.medium);
    _playerController = VideoPlayerController.file(File(_recording.path));
  }

  preview() async {
    _playerController = VideoPlayerController.file(File(_recording.path));
    await _playerController.initialize();
    await _playerController.setLooping(true);
    await _playerController.play();
  }
}
