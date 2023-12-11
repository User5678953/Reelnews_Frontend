import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FetchSourcesWidget extends StatefulWidget {
  @override
  _FetchSourcesWidgetState createState() => _FetchSourcesWidgetState();
}

class _FetchSourcesWidgetState extends State<FetchSourcesWidget> {
  List<String> sourceNames = [];

  // Fetch sources from GNews API
  Future<void> fetchSources() async {
    try {
      // Updated URL to the GNews API endpoint for sources
      String url =
          'https://gnews.io/api/v4/sources?lang=en&country=us&apikey=a579a4147a5089e75fd1164a4d7331e1';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'ok') {
          // Extract source names from the response data
          final sources = data['sources'];
          for (var source in sources) {
            sourceNames.add(source['name']);
          }

          setState(() {});
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
  void initState() {
    super.initState();
    fetchSources();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: sourceNames.isEmpty
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: sourceNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(sourceNames[index]),
                );
              },
            ),
    );
  }
}
