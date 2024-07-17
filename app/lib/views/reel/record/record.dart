import 'package:app/models/camera.dart';
import 'package:app/models/player.dart';
import 'package:app/views/reel/record/preview.dart';
import 'package:app/views/reel/record/button.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SageRecordReel extends StatelessWidget {
  const SageRecordReel({super.key});

  @override
  Widget build(BuildContext context) {
    var cameraModel = Provider.of<CameraModel>(context);
    var playerModel = Provider.of<PlayerModel>(context, listen: false);

    return FutureBuilder(
        future: cameraModel.init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container();
          }

          return Center(
            child: Stack(
              children: [
                const SageCameraPreview(),
                SageRecordButton(
                  onStartRecording: () {
                    cameraModel.controller.startVideoRecording();
                  },
                  onStopRecording: () async {
                    if (cameraModel.controller.value.isRecordingVideo) {
                      playerModel.recording =
                          await cameraModel.controller.stopVideoRecording();

                      cameraModel.controller.dispose();

                      if (context.mounted) {
                        context.go('/reel/choose');
                      }
                    }
                  },
                )
              ],
            ),
          );
        });
  }
}
