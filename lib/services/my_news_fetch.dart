import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FetchSourcesWidget extends StatefulWidget {
  final Function(List<String>) onSourcesFetched;

  FetchSourcesWidget({Key? key, required this.onSourcesFetched})
      : super(key: key);

  @override
  _FetchSourcesWidgetState createState() => _FetchSourcesWidgetState();
}

class _FetchSourcesWidgetState extends State<FetchSourcesWidget> {
  @override
  void initState() {
    super.initState();
    fetchSources();
  }

  Future<void> fetchSources() async {
    List<String> sourceNames = [];
    try {
      String url =
          'https://gnews.io/api/v4/top-headlines?category=health&lang=en&country=us&max=25&apikey=a579a4147a5089e75fd1164a4d7331e1';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'ok') {
          final sources = data['sources'];
          for (var source in sources) {
            sourceNames.add(source['name']);
          }

          widget.onSourcesFetched(sourceNames);
        } else {
          print('Failed to fetch sources: ${data['message']}');
        }
      } else {
        print('Failed to fetch sources: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching sources: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return SizedBox.shrink();
  }
}
