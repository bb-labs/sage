import 'package:app/models/feed.dart';
import 'package:app/models/user.dart';
import 'package:app/views/feed/reel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageFeed extends StatelessWidget {
  const SageFeed({super.key});

  @override
  Widget build(BuildContext context) {
    var feedModel = Provider.of<FeedModel>(context, listen: false);
    var userModel = Provider.of<UserModel>(context);

    return FutureBuilder(
        future: feedModel.init(userModel.user),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container();
          }

          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: feedModel.feed.users.length,
            itemBuilder: (context, index) {
              return SageReel(user: feedModel.feed.users[index]);
            },
          );
        });
  }
}
