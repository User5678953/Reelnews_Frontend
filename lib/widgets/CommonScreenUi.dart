import 'package:flutter/material.dart';
import 'package:reel_news/widgets/AppBar_Widget.dart';
import 'package:reel_news/screens/auth_views/login_screen.dart';
import 'package:reel_news/widgets/BottomTabbar_Widget.dart';

class CommonScreenUI extends StatelessWidget {
  final String title;
  final Widget body;
  final int currentIndex;
  final Function(int) onTabTapped;
  final VoidCallback onLogout;

  CommonScreenUI({
    required this.title,
    required this.body,
    required this.currentIndex,
    required this.onTabTapped,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          onMenuTap: () {},
          onLogout: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }),
      body: body,
      bottomNavigationBar: BottomTabbarWidget(
        currentIndex: currentIndex,
        onTabTapped: onTabTapped,
      ),
    );
  }
}
