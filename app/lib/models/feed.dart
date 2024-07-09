import 'package:app/grpc/client.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:app/proto/sage.pbgrpc.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FeedModel with ChangeNotifier {
  static int maxNumControllers = 5;

  // Feed data
  Feed _feed = Feed();
  Feed get feed => _feed;
  set feed(Feed feed) {
    _feed = feed;
    notifyListeners();
  }

  int _startIndex = 0;
  int get startIndex => _startIndex;
  set startIndex(int startIndex) {
    _startIndex = startIndex;
    notifyListeners();
  }

  int _endIndex = maxNumControllers - 1;
  int get endIndex => _endIndex;
  set endIndex(int endIndex) {
    _endIndex = endIndex;
    notifyListeners();
  }

  // VideoPlayerControllers
  List<VideoPlayerController> _controllers = [];
  List<VideoPlayerController> get controllers => _controllers;
  set controllers(List<VideoPlayerController> controllers) {
    _controllers = controllers;
    notifyListeners();
  }

  // Methods
  init(User user) async {
    var feedResponse = await SageClientSingleton()
        .instance
        .getFeed(GetFeedRequest(user: user));
    feed = feedResponse.feed;
    for (var i = 0; i < maxNumControllers; i++) {
      var controller = await createController(i);
      _controllers.add(controller);
    }
  }

  grow(int index) async {
    var mid = (startIndex + endIndex) / 2;
    if (index > mid) {
      await slideControllerWindowForward();
    } else if (index < mid) {
      await slideControllerWindowBackward();
    }
    return _controllers[index - startIndex];
  }

  getController(int index) {
    return _controllers[index - startIndex];
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

  slideControllerWindowForward() async {
    if (endIndex == feed.users.length - 1) {
      return;
    }
    await pushControllerBack();
    await popControllerFront();
  }

  slideControllerWindowBackward() async {
    if (startIndex == 0) {
      return;
    }
    await pushControllerFront();
    await popControllerBack();
  }

  pushControllerBack() async {
    var controller = await createController(_endIndex + 1);
    _controllers.add(controller);
    _endIndex++;
  }

  pushControllerFront() async {
    var controller = await createController(_startIndex - 1);
    _controllers.insert(0, controller);
    _startIndex--;
  }

  popControllerBack() async {
    await _controllers.last.dispose();
    _controllers.removeLast();
    _endIndex--;
  }

  popControllerFront() async {
    await _controllers.first.dispose();
    _controllers.removeAt(0);
    _startIndex++;
  }
}
