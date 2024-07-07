import 'package:app/grpc/client.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:app/proto/sage.pbgrpc.dart';
import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel with ChangeNotifier {
  // Constants
  static String userKey = "user_id";
  static int maxAge = 50;
  static int minAge = 18;
  static int maxProximity = 50;
  static int minProximity = 1;

  // Defaults
  static DateTime defaultBirthday = DateTime(2000, 1, 1);
  static LatLng defaultLocation = const LatLng(0.0, 0.0);
  static Preferences defaultPreferences = Preferences()
    ..proximity = 1
    ..ageMin = 25
    ..ageMax = 40;

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
  get isDefaultBirthday =>
      _user.hasBirthday() &&
      _user.birthday.year == defaultBirthday.year &&
      _user.birthday.month == defaultBirthday.month &&
      _user.birthday.day == defaultBirthday.day;
  DateTime get birthday => _user.hasBirthday()
      ? DateTime(
          _user.birthday.year,
          _user.birthday.month,
          _user.birthday.day,
        )
      : DateTime(2000, 1, 1);
  set birthday(DateTime birthday) {
    if (!_user.hasBirthday()) _user.birthday = Birthday();
    _user.birthday.mergeFromMessage(Birthday()
      ..year = birthday.year
      ..month = birthday.month
      ..day = birthday.day);
    notifyListeners();
  }

  // Gender(s)
  List<Gender> get gender => _user.gender;
  toggleGender(Gender gender) {
    _user.gender.contains(gender)
        ? _user.gender.remove(gender)
        : _user.gender.add(gender);
    notifyListeners();
  }

  // Preferences
  LatLng? get preferredLocation =>
      _user.location.latitude != 0.0 && _user.location.longitude != 0.0
          ? LatLng(_user.location.latitude, _user.location.longitude)
          : null;
  set preferredLocation(LatLng? location) {
    _user.location = location != null
        ? Location(latitude: location.latitude, longitude: location.longitude)
        : Location();
    notifyListeners();
  }

  int get preferredProximity =>
      _user.preferences.proximity != 0 ? _user.preferences.proximity : 1;
  set preferredProximity(int proximity) {
    if (!_user.hasPreferences()) _user.preferences = Preferences();
    _user.preferences.proximity = proximity;
    notifyListeners();
  }

  double get preferredProximityInMeters => user.preferences.proximity * 1600;

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
