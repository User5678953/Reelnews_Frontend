import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FetchSourcesWidget extends StatefulWidget {
  @override
  _FetchSourcesWidgetState createState() => _FetchSourcesWidgetState();
}

class _FetchSourcesWidgetState extends State<FetchSourcesWidget> {
  List<String> sourceTESTNames = ["test",
    "test",
    "test",
    "test",
  ];

  // Fetch sources from GNews API
  Future<void> fetchSources() async {
    try {
      String url =
          'https://gnews.io/api/v4/top-headlines?category=general&apikey=a579a4147a5089e75fd1164a4d7331e1';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'ok') {
          // Extract source names from the response data
          final sources = data['sources'];
          for (var source in sources) {
            sourceTESTNames.add(source['name']);
          }

          setState(() {});
        } else {
          print('Response data: $data');
        }
      } else {
        print('Failed to fetch sources: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching sources: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSources();
  }

  @override
  Widget build(BuildContext context) {
    var responseStatus;
    if (responseStatus == 200) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return SizedBox.shrink();
  }
}
