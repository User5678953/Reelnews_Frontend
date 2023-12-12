import 'package:flutter/material.dart';
import 'package:reel_news/widgets/AppBar_Widget.dart';
import 'package:reel_news/widgets/BottomTabbar_Widget.dart';

class CommonScreenUI extends StatelessWidget {
  final String title;
  final Widget body;

  CommonScreenUI({
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: body,
      bottomNavigationBar: BottomTabbarWidget(),
    );
  }
}
