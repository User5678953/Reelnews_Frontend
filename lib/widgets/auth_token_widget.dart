import 'package:flutter/material.dart';

//This widget is for debugging to display user jwt token from django
class UserTokenWidget extends StatelessWidget {
  final String token;

  UserTokenWidget({required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Token'),
      ),
      body: Center(
        // Display the token on the screen
        child: Text('Token: $token'),
      ),
    );
  }
}
