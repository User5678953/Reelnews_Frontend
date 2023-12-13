import 'package:flutter/material.dart';
import 'package:reel_news/widgets/CommonScreenUI.dart';

class ArchiveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonScreenUI(
      title: 'Archive',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
            child: Text(
              "MyArchives",
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.build,
                    size: 40.0,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
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
          ),
        ],
      ),
    );
  }
}
