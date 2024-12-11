import 'package:flutter/material.dart';

enum HomeScreen { feed, connect }

enum SettingsScreen { list, name, birthday, preferences, location }

enum RegistrationScreen { name, birthday, preferences, location }

enum ReelScreen { choose, record }

class NavigationModel with ChangeNotifier {
  // Home
  HomeScreen _homeScreen = HomeScreen.feed;
  HomeScreen get homeScreen => _homeScreen;
  set homeScreen(HomeScreen screen) {
    _homeScreen = screen;
    notifyListeners();
  }

  // Settings
  SettingsScreen _settingsScreen = SettingsScreen.list;
  SettingsScreen get settingsScreen => _settingsScreen;
  set settingsScreen(SettingsScreen screen) {
    _settingsScreen = screen;
    notifyListeners();
  }

  final PageController _settingsController = PageController();
  PageController get settingsController => _settingsController;

  // Registration
  RegistrationScreen _registrationScreen = RegistrationScreen.name;
  RegistrationScreen get registrationScreen => _registrationScreen;
  set registrationScreen(RegistrationScreen screen) {
    _registrationScreen = screen;
    notifyListeners();
  }

  final PageController _registrationController = PageController();
  PageController get registrationController => _registrationController;

  // Reel
  ReelScreen _reelScreen = ReelScreen.record;
  ReelScreen get reelScreen => _reelScreen;
  set reelScreen(ReelScreen screen) {
    _reelScreen = screen;
    notifyListeners();
  }

  bool _reelKeyboardVisible = false;
  bool get reelKeyboardVisible => _reelKeyboardVisible;
  set reelKeyboardVisible(bool visible) {
    _reelKeyboardVisible = visible;
    notifyListeners();
  }

  final PageController _reelController =
      PageController(initialPage: ReelScreen.choose.index);
  PageController get reelController => _reelController;
}
