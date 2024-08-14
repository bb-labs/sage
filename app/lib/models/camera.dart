import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

enum CameraDirection { front, back }

class CameraModel with ChangeNotifier {
  List<CameraDescription> _cameras = [];
  List<CameraDescription> get cameras => _cameras;

  CameraDirection _cameraDirection = CameraDirection.front;
  CameraDirection get cameraDirection => _cameraDirection;
  set cameraDirection(CameraDirection value) {
    _cameraDirection = value;
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
    switch (_cameraDirection) {
      case CameraDirection.front:
        return _frontCameraController;
      case CameraDirection.back:
        return _backCameraController;
    }
  }

  init() async {
    print('CameraModel init');
    _cameras = await availableCameras();
    _frontCameraController = CameraController(
      _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      ),
      ResolutionPreset.max,
    );
    _backCameraController = CameraController(
      _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      ),
      ResolutionPreset.max,
    );

    await prepareToRecord();
  }

  toggleCamera() {
    switch (_cameraDirection) {
      case CameraDirection.front:
        _cameraDirection = CameraDirection.back;
        break;
      case CameraDirection.back:
        _cameraDirection = CameraDirection.front;
        break;
    }
  }

  prepareToRecord() async {
    await controller?.initialize().then((_) {
      controller?.prepareForVideoRecording();
    });
  }

  @override
  void dispose() {
    if (_frontCameraController != null) {
      _frontCameraController?.dispose();
      _frontCameraController = null;
    }
    if (_backCameraController != null) {
      _backCameraController?.dispose();
      _backCameraController = null;
    }
    super.dispose();
  }
}
