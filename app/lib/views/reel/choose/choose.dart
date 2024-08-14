import 'package:app/models/navigation.dart';
import 'package:app/models/player.dart';
import 'package:app/views/reel/choose/buttons.dart';
import 'package:app/views/reel/choose/player.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageChooseReel extends StatelessWidget {
  const SageChooseReel({super.key});

  @override
  Widget build(BuildContext context) {
    var playerModel = Provider.of<PlayerModel>(context);
    var navigationModel = Provider.of<NavigationModel>(context);

    if (navigationModel.reelScreen != ReelScreen.choose) {
      return Container();
    }

    return FutureBuilder(
      future: playerModel.init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container();
        }

        return const Center(
          child: Stack(
            children: [
              SageVideoPlayer(),
              SageReelSelectionButtons(),
            ],
          ),
        );
      },
    );
  }
}
