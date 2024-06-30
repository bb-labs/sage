import 'package:app/models/player.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageReelSelection extends StatelessWidget {
  const SageReelSelection({super.key});

  @override
  Widget build(BuildContext context) {
    var playerModel = Provider.of<PlayerModel>(context);

    return Column(
      children: [
        const Spacer(
          flex: 8,
        ),
        Row(
          children: [
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
              ),
              onPressed: () {
                playerModel.playerController.dispose();
                playerModel.recording = XFile('');
              },
              child: const Icon(Icons.delete_outline_outlined,
                  color: Colors.black),
            ),
            const Spacer(flex: 4),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
              ),
              onPressed: () {},
              child: const Icon(Icons.check, color: Colors.green),
            ),
            const Spacer(),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
