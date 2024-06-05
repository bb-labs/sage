import 'package:app/proto/sage.pb.dart';
import 'package:flutter/foundation.dart';

enum AuthStatus {
  unknown,
  registering,
  welcome,
  loggedIn,
}

class AuthModel with ChangeNotifier {
  late AuthStatus _status;

  AuthModel(User user) {
    if (user.id.isEmpty) {
      _status = AuthStatus.unknown;
    } else if (!user.hasVideoUrl()) {
      _status = AuthStatus.welcome;
    } else {
      _status = AuthStatus.loggedIn;
    }
  }

  AuthStatus get status => _status;
  set status(AuthStatus value) {
    _status = value;
    notifyListeners();
  }
}
