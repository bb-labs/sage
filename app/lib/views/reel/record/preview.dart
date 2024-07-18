import 'package:app/models/camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageCameraPreview extends StatelessWidget {
  const SageCameraPreview({super.key});

  @override
  Widget build(BuildContext context) {
    var cameraModel = Provider.of<CameraModel>(context);

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    final xScale = size.aspectRatio * (4 / 3);

    return AspectRatio(
      aspectRatio: deviceRatio,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.diagonal3Values(1 / xScale, 1, 1),
        child: CameraPreview(cameraModel.controller!),
      ),
    );
  }
}
