import 'package:app/models/camera.dart';
import 'package:app/views/register/profile/reel/record.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageCreateYourReel extends StatelessWidget {
  const SageCreateYourReel({super.key});

  @override
  Widget build(BuildContext context) {
    var cameraModel = Provider.of<CameraModel>(context);

    return FutureBuilder(
        future: cameraModel.controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container();
          }

          final size = MediaQuery.of(context).size;
          var scale =
              size.aspectRatio * cameraModel.controller.value.aspectRatio;

          // to prevent scaling down, invert the value
          if (scale < 1) scale = 1 / scale;

          return Center(
            child: Stack(
              children: [
                Transform.scale(
                  scale: scale,
                  child: Center(
                    child: CameraPreview(cameraModel.controller),
                  ),
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
        });
  }
}
