import 'package:app/proto/sage.pb.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SageReel extends StatelessWidget {
  final User user;
  final VideoPlayerController controller;
  const SageReel({super.key, required this.controller, required this.user});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return VisibilityDetector(
      key: Key(user.id),
      onVisibilityChanged: (info) async {
        if (info.visibleFraction >= 0.40) {
          controller.play();
        } else {
          controller.pause();
        }
      },
      child: AspectRatio(
        aspectRatio: deviceRatio,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.diagonal3Values(1 / 1, 1, 1),
          child: VideoPlayer(controller),
        ),
      ),
    );
  }
}
