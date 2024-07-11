import 'package:flutter/foundation.dart';

class ReelModel with ChangeNotifier {
  bool _keyboardVisible = false;
  bool get keyboardVisible => _keyboardVisible;
  set keyboardVisible(bool visible) {
    _keyboardVisible = visible;
    notifyListeners();
  }
}
