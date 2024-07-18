import 'package:app/models/camera.dart';
import 'package:app/models/player.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SageGoBackButton extends StatelessWidget {
  const SageGoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    var cameraModel = Provider.of<CameraModel>(context, listen: false);
    var playerModel = Provider.of<PlayerModel>(context, listen: false);

    return Column(
      children: [
        const Spacer(),
        Container(
          decoration: const BoxDecoration(),
          padding: const EdgeInsets.all(40),
          child: IconButton(
            icon: const Icon(
              Icons.close,
              size: 45,
              weight: 100,
              color: Colors.white,
            ),
            onPressed: () {
              if (playerModel.controller != null) {
                playerModel.controller?.dispose();
              }
              if (cameraModel.controller != null) {
                cameraModel.controller?.dispose();
              }
              context.go('/home');
            },
          ),
        ),
        const Spacer(flex: 9),
      ],
    );
  }
}
