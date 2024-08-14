import 'package:app/models/camera.dart';
import 'package:app/models/navigation.dart';
import 'package:app/models/player.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SageRecordButton extends StatefulWidget {
  const SageRecordButton({super.key});

  @override
  State<SageRecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<SageRecordButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cameraModel = Provider.of<CameraModel>(context);
    var playerModel = Provider.of<PlayerModel>(context, listen: false);
    var navigationModel = Provider.of<NavigationModel>(context);

    return Column(
      children: [
        const Spacer(flex: 10),
        Center(
          child: Listener(
            onPointerDown: (_) {
              cameraModel.controller?.startVideoRecording();
              _animationController.repeat();
            },
            onPointerUp: (_) async {
              _animationController.reverse();

              if (cameraModel.controller?.value.isRecordingVideo == true) {
                playerModel.recording =
                    (await cameraModel.controller?.stopVideoRecording())!;

                cameraModel.controller?.dispose();

                navigationModel.reelController
                    .jumpToPage(ReelScreen.choose.index);
              }
            },
            child: Lottie.asset(
              "assets/record.json",
              controller: _animationController,
              width: 145,
              height: 145,
              fit: BoxFit.contain,
              onLoaded: (composition) {
                _animationController.duration = composition.duration;
              },
            ),
          ),
        ),
        const Spacer(flex: 1),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
