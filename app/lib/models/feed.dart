import 'dart:math';

import 'package:app/grpc/client.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:app/proto/sage.pbgrpc.dart';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FeedModel with ChangeNotifier {
  static int maxNumControllers = 5;
  static int halfNumControllers = maxNumControllers ~/ 2;

  // Feed data
  Feed _feed = Feed();
  Feed get feed => _feed;
  set feed(Feed feed) {
    _feed = feed;
    notifyListeners();
  }

  // VideoPlayerControllers
  Map<int, VideoPlayerController> _controllers = {};
  Map<int, VideoPlayerController> get controllers => _controllers;
  set controllers(Map<int, VideoPlayerController> controllers) {
    _controllers = controllers;
    notifyListeners();
  }

  // Methods
  init(User user) async {
    var feedResponse = await SageClientSingleton()
        .instance
        .getFeed(GetFeedRequest(user: user));
    feed = feedResponse.feed;
    var controllers = await Future.wait(
        List.generate(maxNumControllers, (_) => null)
            .mapIndexed((i, _) async => createController(i)));
    for (var i = 0; i < maxNumControllers; i++) {
      _controllers[i] = controllers[i];
    }
  }

  getController(int index) {
    return _controllers[index];
  }

  createController(int index) async {
    var user = feed.users[index];
    var controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://sage-reels-dev-bucket.s3.us-west-2.amazonaws.com/${user.id}.mp4',
      ),
    );
    await controller.initialize();
    await controller.setLooping(true);
    return controller;
  }

  growControllers(int index) async {
    // Dispose of and remove all controllers that are not in the window
    var toRemove = <int>{};
    var lower = max(0, index - halfNumControllers);
    var upper = min(feed.users.length - 1, index + halfNumControllers);
    for (var i in _controllers.keys) {
      if (i < lower || i > upper) {
        toRemove.add(i);
        _controllers[i]?.dispose();
      }
    }
    for (var ri in toRemove) {
      _controllers.remove(ri);
    }

    // Ensure all controllers in the window are initialized
    for (var i = lower; i <= upper; i++) {
      if (!_controllers.containsKey(i)) {
        _controllers[i] = await createController(i);
      }
    }
  }
}
