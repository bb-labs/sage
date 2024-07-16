import 'package:app/models/like.dart';
import 'package:app/models/reel.dart';
import 'package:app/models/user.dart';
import 'package:app/proto/sage.pb.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SageInteractions extends StatelessWidget {
  final User otherUser;
  const SageInteractions({super.key, required this.otherUser});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    var reelModel = Provider.of<ReelModel>(context);
    var likeModel = Provider.of<LikeModel>(context);

    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Spacer(),
          IconButton(
            iconSize: 35,
            color: likeModel.likedUsers.contains(otherUser.id)
                ? Colors.red
                : Colors.white,
            icon: Icon(
              likeModel.likedUsers.contains(otherUser.id)
                  ? Icons.favorite
                  : Icons.favorite_border_rounded,
            ),
            onPressed: () async {
              likeModel.toggleLike(userModel.user, otherUser);
              HapticFeedback.mediumImpact();
            },
          ),
          const SizedBox(height: 25),
          IconButton(
            iconSize: 35,
            color: Colors.white,
            icon: const Icon(Icons.chat_rounded),
            onPressed: () {
              reelModel.keyboardVisible = true;
            },
          ),
        ],
      ),
    );
  }
}
