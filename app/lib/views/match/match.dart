import 'package:app/models/match.dart';
import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class SageMatches extends StatelessWidget {
  const SageMatches({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context, listen: false);
    var matchModel = Provider.of<MatchModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Matches'),
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
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: matchModel.likes.length,
                    itemBuilder: (BuildContext context, int index) {
                      var user = matchModel.likes[index];
                      var controller = matchModel.controllers[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        clipBehavior: Clip.hardEdge,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            clipBehavior: Clip.hardEdge,
                            child: VideoPlayer(controller!),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (100 / 100),
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridTile(
                          child: Text(
                            'Match $index',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }
}
