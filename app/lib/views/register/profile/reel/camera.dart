import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class SageCameraViewer extends StatefulWidget {
  final CameraDescription cameraDescription;

  const SageCameraViewer({super.key, required this.cameraDescription});

  @override
  State<SageCameraViewer> createState() => _SageCameraViewerState();
}

class _SageCameraViewerState extends State<SageCameraViewer> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();

    controller =
        CameraController(widget.cameraDescription, ResolutionPreset.medium);

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    // fetch screen size
    final size = MediaQuery.of(context).size;

    // calculate scale depending on screen and camera ratios
    // this is actually size.aspectRatio / (1 / camera.aspectRatio)
    // because camera preview size is received as landscape
    // but we're calculating for portrait orientation
    var scale = size.aspectRatio * controller.value.aspectRatio;

    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;

    return Transform.scale(
      scale: scale,
      child: Center(
        child: CameraPreview(controller),
      ),
    );
  }
}
