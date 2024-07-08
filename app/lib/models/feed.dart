import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

class FeedModel with ChangeNotifier {
  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  final List<BetterPlayerController> _playerControllers = [];
  List<BetterPlayerController> get playerControllers => _playerControllers;
}
