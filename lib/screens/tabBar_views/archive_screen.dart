import 'package:flutter/material.dart';
import 'package:reel_news/widgets/CommonScreenUI.dart';


class ArchiveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonScreenUI(
      title: 'Archive', 
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.build, 
              size: 40.0,
              color: Colors.grey,
            ),
            SizedBox(
                height: 10), 
            Text(
              'Feature Under Development',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
