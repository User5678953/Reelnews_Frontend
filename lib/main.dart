import 'package:flutter/material.dart';
//import 'package:reel_news/screens/initial_news_screen.dart';

import 'package:reel_news/screens/auth_views/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reel News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: LoginScreen(),
     
    );
  }
}
