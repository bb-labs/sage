import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

class PlayerModel with ChangeNotifier {
  VideoPlayerController? _controller;
  VideoPlayerController? get controller {
    return _controller;
  }

  XFile _recording = XFile('');
  XFile get recording => _recording;
  set recording(XFile value) {
    _recording = value;
    notifyListeners();
  }

  init() async {
    _controller = VideoPlayerController.file(File(_recording.path));
    await _controller!.initialize();
    await _controller!.setLooping(true);
    await _controller!.play();
  }

  @override
  dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
