import 'package:app/models/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class SageVideoPlayer extends StatelessWidget {
  const SageVideoPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    var playerModel = Provider.of<PlayerModel>(context);

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    final xScale = size.aspectRatio * (4 / 3);

    return AspectRatio(
      aspectRatio: deviceRatio,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.diagonal3Values(1 / xScale, 1, 1),
        child: VideoPlayer(playerModel.controller!),
      ),
    );
  }
}
