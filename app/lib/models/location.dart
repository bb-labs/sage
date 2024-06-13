import 'package:geolocator/geolocator.dart';

import 'package:flutter/foundation.dart';

class LocationModel with ChangeNotifier {
  late LocationPermission _permission;
  late Position _position;

  Position get position => _position;
  set position(Position position) {
    _position = position;
    notifyListeners();
  }

  init() async {
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (_permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    _position = await Geolocator.getCurrentPosition();
  }
}
