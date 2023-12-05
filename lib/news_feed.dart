import 'package:flutter/material.dart';

class NewsFeed extends StatelessWidget {
  final String token;

  NewsFeed({required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Feed'),
      ),
      body: Center(
        // Display the token on the screen
        child: Text('Token: $token'),
      ),
    );
  }
}
