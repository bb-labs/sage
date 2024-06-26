import 'package:app/models/camera.dart';
import 'package:app/views/register/hud/navigation.dart';
import 'package:app/views/register/profile/reel/select.dart';
import 'package:app/views/register/profile/reel/viewer.dart';
import 'package:app/views/register/profile/reel/preview.dart';
import 'package:app/views/register/profile/reel/record.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageCreateYourReel extends StatelessWidget {
  const SageCreateYourReel({super.key});

  @override
  Widget build(BuildContext context) {
    var cameraModel = Provider.of<CameraModel>(context);

    return FutureBuilder(
        future: cameraModel.cameraController.initialize().then((value) async {
          await cameraModel.cameraController.prepareForVideoRecording();
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container();
          }

          return Center(
            child: Stack(
              children: [
                cameraModel.recording.path.isEmpty
                    ? const SageCameraViewer()
                    : const SageCameraPreview(),
                cameraModel.recording.path.isEmpty
                    ? SageRecordButton(
                        onStartRecording: () {
                          cameraModel.cameraController.startVideoRecording();
                        },
                        onStopRecording: () async {
                          if (cameraModel
                              .cameraController.value.isRecordingVideo) {
                            var recording = await cameraModel.cameraController
                                .stopVideoRecording();
                            cameraModel.recording = recording;
                          }
                        },
                      )
                    : const SageReelSelection(),
              ],
            ),
          );
        });
  }
}
