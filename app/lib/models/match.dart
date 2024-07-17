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

  Map<int, VideoPlayerController> _likeControllers = {};
  Map<int, VideoPlayerController> get likeControllers => _likeControllers;
  set likeControllers(Map<int, VideoPlayerController> likeControllers) {
    _likeControllers = likeControllers;
    notifyListeners();
  }

  List<User> _matches = [];
  get matches => _matches;
  set matches(value) {
    _matches = value;
    notifyListeners();
  }

  Map<int, VideoPlayerController> _matchControllers = {};
  Map<int, VideoPlayerController> get matchControllers => _matchControllers;
  set matchControllers(Map<int, VideoPlayerController> matchControllers) {
    _matchControllers = matchControllers;
    notifyListeners();
  }

  init(User user) async {
    var likeResponse = await SageClientSingleton()
        .instance
        .getLikes(GetLikesRequest(userId: user.id));

    _likes = likeResponse.likes;

    for (var i = 0; i < _likes.length; i++) {
      _likeControllers[i] = VideoPlayerController.networkUrl(
        Uri.parse(
          'https://sage-reels-dev-bucket.s3.us-west-2.amazonaws.com/${_likes[i].id}.mp4',
        ),
      );
      _likeControllers[i]?.initialize();
    }

    var matchResponse = await SageClientSingleton()
        .instance
        .getMatches(GetMatchesRequest(userId: user.id));

    _matches = matchResponse.matches;
    for (var i = 0; i < _matches.length; i++) {
      _matchControllers[i] = VideoPlayerController.networkUrl(
        Uri.parse(
          'https://sage-reels-dev-bucket.s3.us-west-2.amazonaws.com/${_matches[i].id}.mp4',
        ),
      );
      _matchControllers[i]?.initialize();
    }
  }
}
