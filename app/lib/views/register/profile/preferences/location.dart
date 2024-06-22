import 'dart:async';

import 'package:app/models/location.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SageWhereDoYouWantToDate extends StatefulWidget {
  const SageWhereDoYouWantToDate({super.key});

  @override
  State<SageWhereDoYouWantToDate> createState() =>
      SageWhereDoYouWantToDateState();
}

class SageWhereDoYouWantToDateState extends State<SageWhereDoYouWantToDate> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var locationModel = Provider.of<LocationModel>(context);

    if (locationModel.position.floor == null && !_loading) {
      Fluttertoast.showToast(
        msg:
            "The displayed region indicates how far you're willing to travel for a date.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        fontSize: 18.0,
      );
    }

    return _loading && locationModel.position.floor == null
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
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
                _controller.complete(controller);
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
  }
}
