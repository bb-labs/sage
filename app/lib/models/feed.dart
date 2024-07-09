import 'package:app/grpc/client.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:app/proto/sage.pbgrpc.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FeedModel with ChangeNotifier {
  Feed _feed = Feed();
  Feed get feed => _feed;
  set feed(Feed feed) {
    _feed = feed;
    notifyListeners();
  }

  Map<String, VideoPlayerController> _playerControllers = {};
  Map<String, VideoPlayerController> get playerControllers =>
      _playerControllers;
  set playerControllers(Map<String, VideoPlayerController> playerControllers) {
    _playerControllers = playerControllers;
    notifyListeners();
  }

  init(User user) async {
    return SageClientSingleton()
        .instance
        .getFeed(GetFeedRequest(user: user))
        .then((value) => feed = value.feed);
  }

  initController(String id) async {
    if (_playerControllers[id] == null) {
      final controller = VideoPlayerController.networkUrl(Uri.parse(
          'https://sage-reels-dev-bucket.s3.us-west-2.amazonaws.com/$id.mp4'));
      await controller.initialize();
      await controller.setLooping(true);
      _playerControllers[id] = controller;
    }

    print("Initialized controller for $id");
  }

  VideoPlayerController getController(String id) {
    print("Getting controller for $id ");
    return _playerControllers[id]!;
  }
}
