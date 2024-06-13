import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

class CameraModel with ChangeNotifier {
  late List<CameraDescription> _cameras;

  List<CameraDescription> get cameras => _cameras;

  init() async {
    _cameras = await availableCameras();
  }
}
