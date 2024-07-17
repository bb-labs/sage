import 'package:app/models/match.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class SageMatches extends StatelessWidget {
  const SageMatches({super.key});

  @override
  Widget build(BuildContext context) {
    var matchModel = Provider.of<MatchModel>(context);

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: deviceRatio,
        ),
        itemCount: matchModel.matches.length,
        itemBuilder: (BuildContext context, int index) {
          var controller = matchModel.matchControllers[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: deviceRatio,
              child: SizedBox(
                height: 200,
                child: VideoPlayer(controller!),
              ),
            ),
          );
        },
      ),
    );
  }
}
