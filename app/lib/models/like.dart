import 'package:app/grpc/client.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:flutter/foundation.dart';

class LikeModel with ChangeNotifier {
  final Set<String> _likedUsers = {};
  get likedUsers => _likedUsers;

  _likeUser(User user, User otherUser) async {
    await SageClientSingleton().instance.likeUser(LikeUserRequest(
          like: Like(
            userId: user.id,
            otherUserId: otherUser.id,
          ),
        ));
    _likedUsers.add(otherUser.id);

    notifyListeners();
  }

  _unlikeUser(User user, User otherUser) async {
    await SageClientSingleton().instance.unlikeUser(UnlikeUserRequest(
          like: Like(
            userId: user.id,
            otherUserId: otherUser.id,
          ),
        ));
    _likedUsers.remove(otherUser.id);

    notifyListeners();
  }

  toggleLike(User user, User otherUser) async {
    if (_likedUsers.contains(otherUser.id)) {
      await _unlikeUser(user, otherUser);
    } else {
      await _likeUser(user, otherUser);
    }

    notifyListeners();
  }
}
