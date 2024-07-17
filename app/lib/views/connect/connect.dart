import 'package:app/models/match.dart';
import 'package:app/models/user.dart';
import 'package:app/views/connect/likes.dart';
import 'package:app/views/connect/matches.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageConnections extends StatelessWidget {
  const SageConnections({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context, listen: false);
    var matchModel = Provider.of<MatchModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Connections',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder(
          future: matchModel.init(userModel.user),
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
