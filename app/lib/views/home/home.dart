import 'package:app/models/navigation.dart';
import 'package:app/views/feed/feed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageHome extends StatelessWidget {
  const SageHome({super.key});

  static const fields = [
    SageFeed(),
    SageFeed(),
    SageFeed(),
  ];

  @override
  Widget build(BuildContext context) {
    var navigationModel = Provider.of<NavigationModel>(context);
    return Scaffold(
      body: fields[navigationModel.selectedIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_front),
              label: 'Reels',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Matches',
            ),
          ],
          currentIndex: navigationModel.selectedIndex,
          onTap: (index) => navigationModel.selectedIndex = index,
        ),
      ),
    );
  }
}
