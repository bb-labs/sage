import 'package:app/models/camera.dart';
import 'package:app/models/player.dart';
import 'package:app/views/registration/reel/select.dart';
import 'package:app/views/registration/reel/preview.dart';
import 'package:app/views/registration/reel/player.dart';
import 'package:app/views/registration/reel/record.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageCreateYourReel extends StatelessWidget {
  const SageCreateYourReel({super.key});

  @override
  Widget build(BuildContext context) {
    var cameraModel = Provider.of<CameraModel>(context);
    var playerModel = Provider.of<PlayerModel>(context);
    var needReel = playerModel.recording.path.isEmpty;

    return FutureBuilder(
        future: needReel ? cameraModel.init() : playerModel.init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container();
          }

          return Center(
            child: Stack(
              children: [
                needReel ? const SageCameraPreview() : const SageVideoPlayer(),
                needReel
                    ? SageRecordButton(
                        onStartRecording: () {
                          cameraModel.cameraController.startVideoRecording();
                        },
                        onStopRecording: () async {
                          if (cameraModel.isRecording()) {
                            var recording = await cameraModel.stopRecording();
                            playerModel.recording = recording;
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
