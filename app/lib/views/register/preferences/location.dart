import 'package:app/models/location.dart';
import 'package:app/models/user.dart';
import 'package:app/proto/sage.pb.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:protobuf/protobuf.dart';
import 'package:provider/provider.dart';

class SageWhereDoYouWantToDate extends StatelessWidget {
  const SageWhereDoYouWantToDate({super.key});

  @override
  Widget build(BuildContext context) {
    var locationModel = Provider.of<LocationModel>(context, listen: false);

    return FutureBuilder(
        future: locationModel.init(),
        builder: (context, snapshot) {
          var userModel = Provider.of<UserModel>(context);
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
                  userModel.user.hasLocation()
                      ? userModel.user.location.latitude
                      : locationModel.position.latitude,
                  userModel.user.hasLocation()
                      ? userModel.user.location.longitude
                      : locationModel.position.longitude,
                ),
                zoom: locationModel.position.floor == null
                    ? 15
                    : locationModel.position.floor!.toDouble(),
              ),
              onMapCreated: (GoogleMapController controller) {
                if (!locationModel.mapController.isCompleted) {
                  locationModel.mapController.complete(controller);
                }
                if (userModel.user.preferences.hasRegion()) {
                  controller.moveCamera(
                    CameraUpdate.newLatLngBounds(
                        LatLngBounds(
                          southwest: LatLng(
                            userModel
                                .user.preferences.region.southwest.latitude,
                            userModel
                                .user.preferences.region.southwest.longitude,
                          ),
                          northeast: LatLng(
                            userModel
                                .user.preferences.region.northeast.latitude,
                            userModel
                                .user.preferences.region.northeast.longitude,
                          ),
                        ),
                        0.0),
                  );
                }
              },
              onCameraMove: (CameraPosition position) async {
                locationModel.position = Position.fromMap({
                  'latitude': position.target.latitude,
                  'longitude': position.target.longitude,
                  'floor': position.zoom.round(),
                });

                final newUser = userModel.user.deepCopy();
                newUser.location = newUser.hasLocation()
                    ? newUser.location.deepCopy()
                    : Location();
                newUser.location.latitude = position.target.latitude;
                newUser.location.longitude = position.target.longitude;

                var controller = await locationModel.mapController.future;
                var region = await controller.getVisibleRegion();

                newUser.preferences = newUser.hasPreferences()
                    ? newUser.preferences.deepCopy()
                    : Preferences();

                newUser.preferences.region = newUser.preferences.hasRegion()
                    ? newUser.preferences.region.deepCopy()
                    : Region();

                newUser.preferences.region.northeast =
                    newUser.preferences.region.hasNortheast()
                        ? newUser.preferences.region.northeast.deepCopy()
                        : Location();

                newUser.preferences.region.southwest =
                    newUser.preferences.region.hasSouthwest()
                        ? newUser.preferences.region.southwest.deepCopy()
                        : Location();

                newUser.preferences.region.northeast.latitude =
                    region.northeast.latitude;
                newUser.preferences.region.northeast.longitude =
                    region.northeast.longitude;
                newUser.preferences.region.southwest.latitude =
                    region.southwest.latitude;
                newUser.preferences.region.southwest.longitude =
                    region.southwest.longitude;

                userModel.user = newUser;
              },
            ),
          );
        });
  }
}
