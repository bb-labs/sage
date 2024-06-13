import 'package:app/models/camera.dart';
import 'package:app/views/profile/button.dart';
import 'package:app/views/profile/camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageCreateYourProfile extends StatelessWidget {
  const SageCreateYourProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var cameraModel = Provider.of<CameraModel>(context);

    return Center(
      child: Stack(
        children: [
          SageCameraViewer(
            cameraDescription: cameraModel.cameras.firstWhere(
                (camera) => camera.lensDirection == CameraLensDirection.front),
          ),
          Column(
            children: [
              const Spacer(flex: 9),
              SageRecordButton(
                onStartRecording: () {
                  print('Recording started');
                },
                onStopRecording: () {
                  print('Recording stopped');
                },
              ),
              const Spacer(flex: 1),
            ],
          ),
        ],
      ),
    );
  }
}
