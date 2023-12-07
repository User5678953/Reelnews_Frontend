import 'package:flutter/material.dart';
// import 'package:reel_news/screens/public_news_screen.dart';
import 'package:reel_news/screens/api_news_screen.dart';
import 'package:reel_news/screens/auth_views/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
      
        colorScheme: ColorScheme.light(
          primary: Color.fromARGB(
              255, 216, 216, 216), 
          onPrimary:
              Colors.black, 
          secondary: Color(0xFF32CD32), 
          onSecondary: Colors.white, 
          surface: Color.fromARGB(255, 241, 237, 236), 
          onSurface: Colors.black, 
        ),

        // AppBar theme
        appBarTheme: AppBarTheme(
          backgroundColor:
              Color.fromARGB(255, 0, 85, 0), 
          iconTheme: IconThemeData(color: Colors.white), 
          titleTextStyle: TextStyle(
            color: Colors.white, 
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Text theme
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.black),
          bodyText1: TextStyle(fontSize: 14.0, color: Colors.black),
        ),

        // Button theme with secondary color 
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary:
                Color(0xFF36454F), 
            onPrimary: Colors.white, 
          ),
        ),
      ),
      home: LoginScreen(),
      // home: PublicNewsViews(),
      // home: APINewsScreen(),
    );
  }
}
