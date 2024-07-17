import 'package:app/models/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SageBottomNavigationBar extends StatelessWidget {
  const SageBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    var navigationModel = Provider.of<NavigationModel>(context);
    return Theme(
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
    );
  }
}
