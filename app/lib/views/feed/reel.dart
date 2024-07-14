import 'package:app/models/reel.dart';
import 'package:app/proto/sage.pb.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SageReel extends StatelessWidget {
  final User user;
  final VideoPlayerController controller;
  const SageReel({super.key, required this.controller, required this.user});

  @override
  Widget build(BuildContext context) {
    var reelModel = Provider.of<ReelModel>(context);

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom -
        kBottomNavigationBarHeight * 1.75;

    return VisibilityDetector(
      key: Key(user.id),
      onVisibilityChanged: (info) async {
        if (info.visibleFraction >= 0.40) {
          controller.play();
        } else {
          controller.pause();
        }
      },
      child: AspectRatio(
        aspectRatio: deviceRatio,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.diagonal3Values(1 / 1, 1, 1),
          child: Stack(
            children: [
              VideoPlayer(controller),
              Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Spacer(flex: 12),
                    IconButton(
                      iconSize: 35,
                      color: Colors.white,
                      icon: const Icon(Icons.favorite_border_outlined),
                      onPressed: () {},
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
                    const Spacer(flex: 1),
                  ],
                ),
              ),
              Visibility(
                visible: reelModel.keyboardVisible,
                child: Column(
                  children: [
                    const Spacer(),
                    TextFormField(
                      autofocus: true,
                      maxLines: null,
                      textInputAction: TextInputAction.send,
                      onEditingComplete: () {
                        reelModel.keyboardVisible = false;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Type in your text",
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    bottomInset > kBottomNavigationBarHeight * 1.75
                        ? SizedBox(height: bottomInset)
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
