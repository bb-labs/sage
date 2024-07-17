import 'package:app/models/navigation.dart';
import 'package:app/views/feed/feed.dart';
import 'package:app/views/connect/connect.dart';
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
        index: navigationModel.selectedIndex,
        children: const [
          SageFeed(),
          SageConnections(),
        ],
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: SizedBox(
          height: kBottomNavigationBarHeight * 1.75,
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.camera_rear, size: 30),
                label: 'Reels',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people, size: 30),
                label: 'Matches',
              ),
            ],
            currentIndex: navigationModel.selectedIndex,
            onTap: (index) => navigationModel.selectedIndex = index,
          ),
        ),
      ),
    );
  }
}
