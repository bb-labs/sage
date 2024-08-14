import 'package:app/models/camera.dart';
import 'package:app/models/navigation.dart';
import 'package:app/models/player.dart';
import 'package:app/views/reel/choose/choose.dart';
import 'package:app/views/reel/record/record.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SageReelPicker extends StatelessWidget {
  const SageReelPicker({super.key});

  @override
  Widget build(BuildContext context) {
    var cameraModel = Provider.of<CameraModel>(context, listen: false);
    var playerModel = Provider.of<PlayerModel>(context, listen: false);
    var navigationModel = Provider.of<NavigationModel>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            cameraModel.dispose();
            playerModel.dispose();
            context.go('/home');
          },
          icon: const Icon(
            Icons.close,
            size: 45,
            weight: 100,
            color: Colors.white,
          ),
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: navigationModel.reelController,
        onPageChanged: (index) {
          navigationModel.reelScreen = ReelScreen.values[index];
        },
        children: const [
          SageChooseReel(),
          SageRecordReel(),
        ],
      ),
    );
  }
}
