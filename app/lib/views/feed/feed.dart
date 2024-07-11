import 'package:app/models/feed.dart';
import 'package:app/models/user.dart';
import 'package:app/views/feed/reel.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageFeed extends StatelessWidget {
  const SageFeed({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);

    return FutureBuilder(
      future:
          Provider.of<FeedModel>(context, listen: false).init(userModel.user),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        var feedModel = Provider.of<FeedModel>(context);

        return PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: feedModel.feed.users.length,
          onPageChanged: (index) async {
            await feedModel.growControllers(index);
          },
          itemBuilder: (context, index) {
            print("Building reel for user ${feedModel.feed.users[index].id}");
            return SageReel(
              user: feedModel.feed.users[index],
              controller: feedModel.getController(index),
            );
          },
        );
      },
    );
  }
}
