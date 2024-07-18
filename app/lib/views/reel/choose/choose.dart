import 'package:app/models/player.dart';
import 'package:app/models/user.dart';
import 'package:app/views/reel/choose/buttons.dart';
import 'package:app/views/reel/choose/player.dart';
import 'package:app/views/reel/reel.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageChooseReel extends StatelessWidget {
  const SageChooseReel({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context, listen: false);
    var playerModel = Provider.of<PlayerModel>(context);

    return FutureBuilder(
        future: playerModel.init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container();
          }

          return Center(
            child: Stack(
              children: [
                const SageVideoPlayer(),
                const SageReelSelectionButtons(),
                if (userModel.authStatus == AuthStatus.loggedIn)
                  const SageGoBackButton(),
              ],
            ),
          );
        });
  }
}
