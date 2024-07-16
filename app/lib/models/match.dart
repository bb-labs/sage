import 'package:app/grpc/client.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

class MatchModel with ChangeNotifier {
  List<User> _likes = [];
  get likes => _likes;
  set likes(value) {
    _likes = value;
    notifyListeners();
  }

  Map<int, VideoPlayerController> _controllers = {};
  Map<int, VideoPlayerController> get controllers => _controllers;
  set controllers(Map<int, VideoPlayerController> controllers) {
    _controllers = controllers;
    notifyListeners();
  }

  List<User> _matches = [];
  get matches => _matches;
  set matches(value) {
    _matches = value;
    notifyListeners();
  }

  init(User user) async {
    var likeResponse = await SageClientSingleton()
        .instance
        .getLikes(GetLikesRequest(userId: user.id));

    _likes = likeResponse.likes;

    for (var i = 0; i < _likes.length; i++) {
      _controllers[i] = VideoPlayerController.networkUrl(
        Uri.parse(
          'https://sage-reels-dev-bucket.s3.us-west-2.amazonaws.com/${_likes[i].id}.mp4',
        ),
      );
      _controllers[i]?.initialize();
    }

    var matchResponse = await SageClientSingleton()
        .instance
        .getMatches(GetMatchesRequest(userId: user.id));

    _matches = matchResponse.matches;
  }
}
