import 'package:app/models/feed.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SageReel extends StatelessWidget {
  final User user;
  const SageReel({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    var feedModel = Provider.of<FeedModel>(context);

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return FutureBuilder(
      future: feedModel.initController(user.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container();
        }
        return VisibilityDetector(
          key: Key(user.id),
          onVisibilityChanged: (info) async {
            if (info.visibleFraction >= 0.6) {
              feedModel.getController(user.id).play();
            } else {
              feedModel.getController(user.id).pause();
            }
          },
          child: AspectRatio(
            aspectRatio: deviceRatio,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.diagonal3Values(1 / 1, 1, 1),
              child: VideoPlayer(feedModel.getController(user.id)),
            ),
          ),
        );
      },
    );
  }
}
