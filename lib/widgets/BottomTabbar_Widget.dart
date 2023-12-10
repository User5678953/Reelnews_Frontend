import 'package:flutter/material.dart';

class BottomTabbarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  BottomTabbarWidget({required this.currentIndex, required this.onTabTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabTapped,
      backgroundColor: Colors.black,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.archive),
          label: 'MyArchive',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.source),
          label: 'Sources',
        ),
      ],
    );
  }
}
