import 'package:app/grpc/client.dart';
import 'package:app/models/player.dart';
import 'package:app/models/user.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:go_router/go_router.dart';

import 'package:http/http.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class SageReelSelectionButtons extends StatelessWidget {
  const SageReelSelectionButtons({super.key});

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
                playerModel.controller?.dispose();
                playerModel.recording = XFile('');
                context.go('/reel/record');
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
                // Create a loading overlay while the video is uploaded
                final overlay = Overlay.of(context);
                var overlayEntry = OverlayEntry(
                  builder: (context) {
                    return Scaffold(
                      backgroundColor: Colors.black.withOpacity(0.5),
                      body: LoadingAnimationWidget.hexagonDots(
                        color: Colors.white,
                        size: 100,
                      ),
                    );
                  },
                );
                overlay.insert(overlayEntry);

                // Get a presigned URL from the server
                var response = await SageClientSingleton()
                    .instance
                    .createPresignedURL(CreatePresignedURLRequest(
                      action: PresignAction.PUT,
                      fileName: "${userModel.id}.mp4",
                      mimeType: 'video/mp4',
                    ));

                // Upload the video to the presigned URL
                await put(
                  Uri.parse(response.url),
                  body: await playerModel.recording.readAsBytes(),
                  headers: {'Content-Type': 'video/mp4'},
                );

                // Save it locally for future previewing
                var directory = await getApplicationDocumentsDirectory();
                await playerModel.recording
                    .saveTo('${directory.path}/${userModel.id}.mp4');

                // Cleanup the camera and player
                await playerModel.controller?.dispose();

                overlayEntry.remove();
                if (userModel.authStatus == AuthStatus.registering) {
                  userModel.authStatus = AuthStatus.loggedIn;
                }

                // Navigate to the home screen
                if (context.mounted) {
                  context.go('/home');
                  playerModel.recording = XFile('');
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
