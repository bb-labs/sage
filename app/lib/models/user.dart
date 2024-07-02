import 'package:app/grpc/client.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel with ChangeNotifier {
  // Constants
  static String userKey = "user_id";
  static int maxAge = 50;
  static int minAge = 18;

  // User
  User _user = User();
  User get user => _user;
  set user(User user) {
    _user = user;
    notifyListeners();
  }

  // ID
  String get id => _user.id;
  set id(String id) {
    _user.id = id;
    notifyListeners();
  }

  // Name
  String get name => _user.name;
  set name(String name) {
    _user.name = name;
    notifyListeners();
  }

  // Birthday
  DateTime get birthday => _user.hasBirthday()
      ? DateTime(
          _user.birthday.year,
          _user.birthday.month,
          _user.birthday.day,
        )
      : DateTime(1999, 12, 31);
  set birthday(DateTime birthday) {
    if (!_user.hasBirthday()) _user.birthday = Birthday();
    _user.birthday.mergeFromMessage(Birthday()
      ..year = birthday.year
      ..month = birthday.month
      ..day = birthday.day);
    notifyListeners();
  }

  // Gender
  Gender get gender => _user.gender;
  set gender(Gender gender) {
    _user.gender = _user.gender == gender ? Gender.UNKNOWN : gender;
    notifyListeners();
  }

  // Preferences
  double get preferredAgeMin =>
      _user.preferences.hasAgeMin() ? _user.preferences.ageMin.toDouble() : 25;
  set preferredAgeMin(double age) {
    if (!_user.hasPreferences()) _user.preferences = Preferences();
    _user.preferences.ageMin = age.toInt();
    notifyListeners();
  }

  double get preferredAgeMax =>
      _user.preferences.hasAgeMax() ? _user.preferences.ageMax.toDouble() : 40;
  set preferredAgeMax(double age) {
    if (!_user.hasPreferences()) _user.preferences = Preferences();
    _user.preferences.ageMax = age.toInt();
    notifyListeners();
  }

  List<Gender> get preferredGenders => _user.preferences.gender;
  togglePrefferedGender(Gender gender) {
    if (!_user.hasPreferences()) _user.preferences = Preferences(gender: []);
    _user.preferences.gender.contains(gender)
        ? _user.preferences.gender.remove(gender)
        : _user.preferences.gender.add(gender);
    notifyListeners();
  }

  // Methods
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
