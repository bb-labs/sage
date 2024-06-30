import 'package:app/grpc/client.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel with ChangeNotifier {
  static String userKey = "user_id";

  User _user = User();
  User get user => _user;
  set user(User user) {
    _user = user;
    notifyListeners();
  }

  init() async {
    final userID = await lookup();

    if (userID != null) {
      try {
        return SageClientSingleton()
            .instance
            .getUser(GetUserRequest(id: userID))
            .then((response) => _user = response.user);
      } catch (_) {
        return delete();
      }
    }
  }

  lookup() async {
    return SharedPreferences.getInstance()
        .then((prefs) => prefs.getString(userKey));
  }

  store() async {
    return SharedPreferences.getInstance()
        .then((prefs) => prefs.setString(userKey, _user.id));
  }

  delete() async {
    return SharedPreferences.getInstance()
        .then((prefs) => prefs.remove(userKey));
  }
}
