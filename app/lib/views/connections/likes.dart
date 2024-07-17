import 'package:app/models/match.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class SageLikes extends StatelessWidget {
  const SageLikes({super.key});

  @override
  Widget build(BuildContext context) {
    var matchModel = Provider.of<MatchModel>(context);

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: matchModel.likes.length,
        itemBuilder: (BuildContext context, int index) {
          var user = matchModel.likes[index];
          var controller = matchModel.likeControllers[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(400),
                clipBehavior: Clip.hardEdge,
                child: VideoPlayer(controller!),
              ),
            ),
          );
        },
      ),
    );
  }
}
