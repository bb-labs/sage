import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

class CameraModel with ChangeNotifier {
  List<CameraDescription> _cameras = [];
  List<CameraDescription> get cameras => _cameras;

  CameraController? _cameraController;
  CameraController get cameraController {
    if (_cameraController == null) {
      throw Exception('CameraController is not initialized');
    }
    return _cameraController!;
  }

  init() async {
    if (_cameraController != null && cameraController.value.isInitialized) {
      return;
    }

    _cameras = await availableCameras();
    final frontCamera = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);

    _cameraController = CameraController(frontCamera, ResolutionPreset.max);

    return cameraController.initialize().then((value) async {
      await cameraController.prepareForVideoRecording();
    });
  }

  startRecording() async {
    await cameraController.startVideoRecording();
  }

  stopRecording() async {
    return cameraController.stopVideoRecording();
  }

  isRecording() {
    return cameraController.value.isRecordingVideo;
  }

  aspectRatio() {
    return cameraController.value.aspectRatio;
  }
}
