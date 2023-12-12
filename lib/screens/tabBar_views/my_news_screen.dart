import 'package:flutter/material.dart';
import 'package:reel_news/widgets/AppBar_Widget.dart';
import 'package:reel_news/widgets/SearchBar_Widget.dart';


class MyNewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Column(
        children: [
      
          SearchBarWidget(),
          Spacer(),

          Center(
            child: Text('MyNews Screen'),
          ),
        ],
      ),
    );
  }
}
