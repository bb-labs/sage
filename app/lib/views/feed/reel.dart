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
                        reelModel.keyboardVisible = !reelModel.keyboardVisible;
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Type in your text",
                        fillColor: Colors.white70,
                      ),
                    ),
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
