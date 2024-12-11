import 'package:app/models/navigation.dart';
import 'package:app/models/player.dart';
import 'package:app/models/user.dart';
import 'package:app/views/connections/likes.dart';
import 'package:app/views/connections/matches.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class SageConnections extends StatelessWidget {
  const SageConnections({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context, listen: false);
    var playerModel = Provider.of<PlayerModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Connections',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {
            context.push('/settings');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined),
            onPressed: () async {
              var directory = await getApplicationDocumentsDirectory();
              playerModel.recording =
                  XFile('${directory.path}/${userModel.id}.mp4');
              if (context.mounted) {
                context.go('/reel');
              }
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: Future.wait([userModel.getMatches(), userModel.getLikes()]),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Likes',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SageLikes(),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Matches',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SageMatches(),
              ],
            );
          }),
    );
  }
}
