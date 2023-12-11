import 'package:flutter/material.dart';
import 'package:reel_news/screens/initial_news_screen.dart';
import 'package:reel_news/widgets/AppBar_Widget.dart';
import 'package:reel_news/widgets/FetchSourcesWidget.dart'; 

class SourcesScreen extends StatelessWidget {
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
      body: Center(
        child: Column(
          children: [
            Text('Sources Screen'),
            FetchSourcesWidget(), 
          ],
        ),
      ),
    );
  }
}
