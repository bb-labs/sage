import 'package:app/grpc/client.dart';
import 'package:app/models/player.dart';
import 'package:app/models/user.dart';
import 'package:app/proto/sage.pb.dart';

import 'package:http/http.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageReelSelection extends StatelessWidget {
  const SageReelSelection({super.key});

  @override
  Widget build(BuildContext context) {
    var playerModel = Provider.of<PlayerModel>(context);
    var userModel = Provider.of<UserModel>(context);

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
              child: const Icon(Icons.loop_outlined, color: Colors.black),
            ),
            const Spacer(flex: 4),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
              ),
              onPressed: () async {
                var response = await SageClientSingleton()
                    .instance
                    .createPresignedURL(CreatePresignedURLRequest(
                      action: PresignAction.PUT,
                      fileName: userModel.user.id,
                      mimeType: 'video/mp4',
                    ));

                try {
                  var putResponse = await put(
                    Uri.parse(response.url),
                    body: await playerModel.recording.readAsBytes(),
                    headers: {'Content-Type': 'video/mp4'},
                  );
                  print(putResponse.statusCode);
                } catch (e) {
                  print(e);
                }
              },
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
