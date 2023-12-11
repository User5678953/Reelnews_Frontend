import 'package:flutter/material.dart';
import 'package:reel_news/screens/initial_news_screen.dart';
import 'package:reel_news/widgets/AppBar_Widget.dart';
import 'package:reel_news/widgets/SearchBar_Widget.dart';


class DiscoverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        onMenuTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => InitialNewsScreen(),
            ),
          );
        },
        onLogout: () {},
      ),
      body: Column(
        children: [
          // Search Bar
          SearchBarWidget(),

          Spacer(),

          // Text
          Center(
            child: Text('Discover Screen'),
          ),
        ],
      ),
    );
  }
}
