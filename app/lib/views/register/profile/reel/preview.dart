import 'package:app/models/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class SageCameraPreview extends StatelessWidget {
  const SageCameraPreview({super.key});

  @override
  Widget build(BuildContext context) {
    var cameraModel = Provider.of<CameraModel>(context);

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    final xScale =
        size.aspectRatio * cameraModel.cameraController.value.aspectRatio;
    print("size: $size");
    print("scale: $xScale");
    print("deviceRatio: $deviceRatio");
    print("aspectRatio: ${cameraModel.cameraController.value.aspectRatio}");

    return FutureBuilder(
      future: cameraModel.preview(),
      builder: (context, state) {
        if (state.connectionState != ConnectionState.done) {
          return Container();
        }

        return AspectRatio(
          aspectRatio: deviceRatio,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.diagonal3Values(1 / xScale, 1, 1),
            child: VideoPlayer(cameraModel.playerController),
          ),
        );
      },
    );
  }
}
