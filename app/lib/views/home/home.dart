import 'package:app/models/navigation.dart';
import 'package:app/views/feed/feed.dart';
import 'package:app/views/connections/connections.dart';
import 'package:app/views/home/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageHome extends StatelessWidget {
  const SageHome({super.key});

  @override
  Widget build(BuildContext context) {
    var navigationModel = Provider.of<NavigationModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: navigationModel.homeScreen.index,
        children: const [
          SageFeed(),
          SageConnections(),
        ],
      ),
      bottomNavigationBar: const SageHomeNavigationBar(),
    );
  }
}
