import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

class CameraModel with ChangeNotifier {
  late CameraController _controller;
  late List<CameraDescription> _cameras;

  CameraController get controller => _controller;
  List<CameraDescription> get cameras => _cameras;

  init() async {
    _cameras = await availableCameras();
    final frontCamera = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);

    _controller = CameraController(frontCamera, ResolutionPreset.medium);
    return _controller.initialize().then((_) {
      _controller.prepareForVideoRecording();
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }
}
