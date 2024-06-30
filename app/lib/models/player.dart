import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

class PlayerModel with ChangeNotifier {
  VideoPlayerController? _playerController;
  VideoPlayerController get playerController {
    if (_playerController == null) {
      throw Exception('VideoPlayerController is not initialized');
    }
    return _playerController!;
  }

  XFile _recording = XFile('');
  XFile get recording => _recording;
  set recording(XFile value) {
    _recording = value;
    notifyListeners();
  }

  init() async {
    _playerController = VideoPlayerController.file(File(_recording.path));
    await _playerController!.initialize();
    await _playerController!.setLooping(true);
    await _playerController!.play();
  }

  aspectRatio() {
    return playerController.value.aspectRatio;
  }
}
