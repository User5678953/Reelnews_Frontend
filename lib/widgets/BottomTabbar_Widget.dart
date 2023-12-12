import 'package:flutter/material.dart';
import 'package:reel_news/screens/tabBar_views/archive_screen.dart';
import 'package:reel_news/screens/tabBar_views/my_news_screen.dart';
import 'package:reel_news/screens/tabBar_views/sources_screen.dart';

class BottomTabbarWidget extends StatefulWidget {
  @override
  _BottomTabbarWidgetState createState() => _BottomTabbarWidgetState();
}

class _BottomTabbarWidgetState extends State<BottomTabbarWidget> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SourcesScreen()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyNewsScreen()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ArchiveScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onTabTapped,
      backgroundColor: Colors.black,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books),
          label: 'MySources',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper),
          label: 'MyNews', 
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'MyArchives',
        ),
      ],
    );
  }
}
