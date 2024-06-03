import 'package:app/network/client.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel with ChangeNotifier {
  static String userKey = "user_id";

  User _user = User();

  init() async {
    final prefs = await SharedPreferences.getInstance();
    final userIdentifier = prefs.getString(userKey);

    if (userIdentifier != null) {
      try {
        final response = await SageClientSingleton()
            .instance
            .getUser(GetUserRequest(id: userIdentifier));
        _user = response.user;
      } catch (e) {
        print("Error getting user: $e");
        prefs.remove(userKey);
        return;
      }
    }
  }

  save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(userKey, _user.id);
  }

  User get user => _user;
  set user(User user) {
    _user = user;
    notifyListeners();
  }
}
