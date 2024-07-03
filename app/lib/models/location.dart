import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationModel with ChangeNotifier {
  static const tileTemplate =
      'https://tiles.stadiamaps.com/tiles/osm_bright/{z}/{x}/{y}{r}.png?api_key=0b04711d-b4d2-4cd0-bf8d-763dd2cd7f33';

  // Position
  Position _position = Position.fromMap({'latitude': 0.0, 'longitude': 0.0});
  LatLng get position => LatLng(_position.latitude, _position.longitude);
  set position(LatLng position) {
    _position = Position.fromMap({
      'latitude': position.latitude,
      'longitude': position.longitude,
    });
    notifyListeners();
  }

  // Permission
  LocationPermission _permission = LocationPermission.denied;
  LocationPermission get permission => _permission;
  set permission(LocationPermission permission) {
    _permission = permission;
    notifyListeners();
  }

  // Instance methods
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
