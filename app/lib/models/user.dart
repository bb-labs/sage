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
    final userID = await retrieve();

    if (userID != null) {
      try {
        final response = await SageClientSingleton()
            .instance
            .getUser(GetUserRequest(id: userID));
        _user = response.user;
      } catch (_) {
        await delete();
        return;
      }
    }
  }

  retrieve() async {
    final prefs = await SharedPreferences.getInstance();
    final userID = prefs.getString(userKey);
    return userID;
  }

  store() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(userKey, _user.id);
  }

  delete() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(userKey);
  }
}
