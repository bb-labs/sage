import 'package:app/models/location.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SageWhereDoYouWantToDate extends StatelessWidget {
  const SageWhereDoYouWantToDate({super.key});

  @override
  Widget build(BuildContext context) {
    var locationModel = Provider.of<LocationModel>(context, listen: false);
    print('locationModel: $locationModel');

    return FutureBuilder(
        future: locationModel.init(),
        builder: (context, snapshot) {
          var locationModel = Provider.of<LocationModel>(context);

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Scaffold(
            body: GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  locationModel.position.latitude,
                  locationModel.position.longitude,
                ),
                zoom: locationModel.position.floor == null
                    ? 15
                    : locationModel.position.floor!.toDouble(),
              ),
              onMapCreated: (GoogleMapController controller) {
                locationModel.mapController = controller;
              },
              onCameraMove: (CameraPosition position) {
                locationModel.position = Position.fromMap({
                  'latitude': position.target.latitude,
                  'longitude': position.target.longitude,
                  'floor': position.zoom.round(),
                });
              },
            ),
          );
        });
  }
}
