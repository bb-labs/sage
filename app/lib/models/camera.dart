import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

class CameraModel with ChangeNotifier {
  List<CameraDescription> _cameras = [];
  List<CameraDescription> get cameras => _cameras;

  bool _usingFrontCamera = true;
  bool get usingFrontCamera => _usingFrontCamera;
  set usingFrontCamera(bool value) {
    _usingFrontCamera = value;
    notifyListeners();
  }

  CameraController? _frontCameraController;
  CameraController? get frontCameraController {
    return _frontCameraController;
  }

  CameraController? _backCameraController;
  CameraController get backCameraController {
    if (_backCameraController == null) {
      throw Exception('backCameraController is not initialized');
    }
    return _backCameraController!;
  }

  CameraController? get controller {
    if (usingFrontCamera) {
      return frontCameraController;
    } else {
      return backCameraController;
    }
  }

  init() async {
    _cameras = await availableCameras();
    final frontCamera = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    final backCamera = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back);
    _frontCameraController =
        CameraController(frontCamera, ResolutionPreset.max);
    _backCameraController = CameraController(backCamera, ResolutionPreset.max);

    await prepareToRecord();
  }

  toggleCamera() {
    usingFrontCamera = !usingFrontCamera;
  }

  aspectRatio() {
    if (usingFrontCamera) {
      return _frontCameraController?.value.aspectRatio;
    } else {
      return _backCameraController?.value.aspectRatio;
    }
  }

  prepareToRecord() async {
    if (usingFrontCamera) {
      await _frontCameraController?.initialize().then((_) {
        _frontCameraController?.prepareForVideoRecording();
      });
    } else {
      await _backCameraController?.initialize().then((_) {
        _backCameraController?.prepareForVideoRecording();
      });
    }
  }
}
