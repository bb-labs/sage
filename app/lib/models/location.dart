import 'dart:async';

import 'package:geolocator/geolocator.dart';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationModel with ChangeNotifier {
  Position _position = Position.fromMap({'latitude': 0.0, 'longitude': 0.0});
  Position get position => _position;
  set position(Position position) {
    _position = position;
    notifyListeners();
  }

  LocationPermission _permission = LocationPermission.denied;
  LocationPermission get permission => _permission;
  set permission(LocationPermission permission) {
    _permission = permission;
    notifyListeners();
  }

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  set mapController(GoogleMapController controller) {
    if (!_mapController.isCompleted) {
      _mapController.complete(controller);
    }
  }

  init() async {
    if (_mapController.isCompleted) {
      return;
    }

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
