import 'package:flutter/material.dart';
import 'package:reel_news/widgets/AppBar_Widget.dart';

class ArchiveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Center(
        child: Text('Archive Screen'),
      ),
    );
  }
}
