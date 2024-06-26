import 'package:app/models/camera.dart';
import 'package:app/views/profile/button.dart';
import 'package:app/views/profile/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageCreateYourProfile extends StatelessWidget {
  const SageCreateYourProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var cameraModel = Provider.of<CameraModel>(context);

    return FutureBuilder(
        future: cameraModel.init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container();
          }
          return Center(
            child: Stack(
              children: [
                SageCameraViewer(controller: cameraModel.controller),
                Column(
                  children: [
                    const Spacer(flex: 9),
                    SageRecordButton(
                      onStartRecording: () {
                        cameraModel.controller.startVideoRecording();
                      },
                      onStopRecording: () {
                        if (cameraModel.controller.value.isRecordingVideo) {
                          cameraModel.controller.stopVideoRecording();
                        }
                      },
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
