import 'package:flutter/material.dart';
import 'package:reel_news/screens/public_news_screen.dart';
//import 'package:reel_news/screens/api_news_screen.dart';
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
      ),
      home: LoginScreen(),
      //home: PublicNewsScreen(),
       //home: APINewsScreen(),
    );
  }
}
