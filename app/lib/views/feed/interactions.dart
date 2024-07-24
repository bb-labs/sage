import 'package:app/models/navigation.dart';
import 'package:app/models/user.dart';
import 'package:app/proto/sage.pb.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SageInteractions extends StatefulWidget {
  final User otherUser;
  const SageInteractions({super.key, required this.otherUser});

  @override
  State<SageInteractions> createState() => _SageInteractionsState();
}

class _SageInteractionsState extends State<SageInteractions> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    var navigationModel = Provider.of<NavigationModel>(context);

    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Spacer(),
          IconButton(
            iconSize: 35,
            color: _liked ? Colors.red : Colors.white,
            icon: Icon(
              _liked ? Icons.favorite : Icons.favorite_border_rounded,
            ),
            onPressed: () async {
              HapticFeedback.mediumImpact();
              setState(() {
                _liked = true;
              });
              userModel.likeUser(widget.otherUser);
            },
          ),
          const SizedBox(height: 25),
          IconButton(
            iconSize: 35,
            color: Colors.white,
            icon: const Icon(Icons.chat_rounded),
            onPressed: () {
              navigationModel.reelKeyboardVisible = true;
            },
          ),
        ],
      ),
    );
  }
}
