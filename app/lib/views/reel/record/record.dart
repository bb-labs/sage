import 'package:app/models/camera.dart';
import 'package:app/models/navigation.dart';
import 'package:app/views/reel/record/preview.dart';
import 'package:app/views/reel/record/button.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageRecordReel extends StatelessWidget {
  const SageRecordReel({super.key});

  @override
  Widget build(BuildContext context) {
    var cameraModel = Provider.of<CameraModel>(context);
    var navigationModel = Provider.of<NavigationModel>(context);

    if (navigationModel.reelScreen != ReelScreen.record) {
      return Container();
    }

    return FutureBuilder(
      future: cameraModel.init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container();
        }

        return const Center(
          child: Stack(
            children: [
              SageCameraPreview(),
              SageRecordButton(),
            ],
          ),
        );
      },
    );
  }
}
