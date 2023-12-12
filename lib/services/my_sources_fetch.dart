import 'package:flutter/material.dart';

class FetchSourcesWidget extends StatefulWidget {
  @override
  _FetchSourcesWidgetState createState() => _FetchSourcesWidgetState();
}

class _FetchSourcesWidgetState extends State<FetchSourcesWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.black,
        child: Text(
          'Future Feature',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24, 
          ),
        ),
      ),
    );
  }
}
