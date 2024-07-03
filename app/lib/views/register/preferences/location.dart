import 'package:app/models/location.dart';
import 'package:app/models/user.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
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

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return FlutterMap(
            options: MapOptions(
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.drag | InteractiveFlag.pinchZoom,
              ),
              initialCenter:
                  userModel.preferredLocation ?? locationModel.position,
              onPositionChanged: (camera, hasGesture) {
                userModel.preferredLocation = camera.center;
              },
            ),
            children: [
              TileLayer(
                urlTemplate: LocationModel.tileTemplate,
                retinaMode: true,
              ),
              MarkerLayer(markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: userModel.preferredLocation ?? locationModel.position,
                  child: const Icon(
                    Icons.location_on,
                  ),
                ),
              ]),
              CircleLayer(
                circles: [
                  CircleMarker(
                    point:
                        userModel.preferredLocation ?? locationModel.position,
                    radius: 1000,
                    useRadiusInMeter: true,
                    color:
                        ThemeData().colorScheme.outlineVariant.withOpacity(0.5),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
