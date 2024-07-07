import 'package:app/models/location.dart';
import 'package:app/models/user.dart';
import 'package:app/views/registration/fields/fields.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:numberpicker/numberpicker.dart';
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

          return SageField(
            validated: userModel.preferredLocation != null,
            child: OverflowBox(
              minHeight: 1500,
              maxHeight: 1500,
              child: FlutterMap(
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
                  ),
                  MarkerLayer(markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point:
                          userModel.preferredLocation ?? locationModel.position,
                      child: Icon(
                        Icons.location_on,
                        color: ThemeData().colorScheme.primary,
                      ),
                    ),
                  ]),
                  CircleLayer(circles: [
                    CircleMarker(
                      point:
                          userModel.preferredLocation ?? locationModel.position,
                      radius: userModel.preferredProximityInMeters.toDouble(),
                      useRadiusInMeter: true,
                      color: ThemeData()
                          .colorScheme
                          .outlineVariant
                          .withOpacity(0.5),
                    ),
                  ]),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: NumberPicker(
                      haptics: true,
                      value: userModel.preferredProximity,
                      minValue: UserModel.minProximity,
                      maxValue: UserModel.maxProximity,
                      onChanged: (value) {
                        userModel.preferredProximity = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
