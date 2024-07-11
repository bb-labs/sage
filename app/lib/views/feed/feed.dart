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
          physics: feedModel.justStartedReel
              ? const StickyPageViewScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          onPageChanged: (index) async {
            feedModel.justStartedReel = true;
            await feedModel.growControllers(index);
            await Future.delayed(const Duration(milliseconds: 1000), () {
              feedModel.justStartedReel = false;
            });
          },
          itemBuilder: (context, index) {
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

class StickyPageViewScrollPhysics extends ScrollPhysics {
  const StickyPageViewScrollPhysics({super.parent});

  @override
  double get minFlingVelocity => double.infinity;

  @override
  double get maxFlingVelocity => double.infinity;

  @override
  double get minFlingDistance => double.infinity;

  @override
  StickyPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return StickyPageViewScrollPhysics(parent: buildParent(ancestor));
  }
}
