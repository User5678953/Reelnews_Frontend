import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:reel_news/widgets/CommonScreenUI.dart';
import 'package:reel_news/widgets/NewsTile_Widget.dart';

class TechnologyScreen extends StatefulWidget {
  @override
  _TechnologyScreenState createState() => _TechnologyScreenState();
}

class _TechnologyScreenState extends State<TechnologyScreen> {
  List<Map<String, dynamic>> technologyNews = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchTechnologyNews();
  }

  Future<void> fetchTechnologyNews() async {
    setState(() {
      _loading = true;
    });

    final url =
        'https://gnews.io/api/v4/top-headlines?category=technology&lang=en&country=us&max=10&apikey=a579a4147a5089e75fd1164a4d7331e1';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<Map<String, dynamic>> articles =
            List<Map<String, dynamic>>.from(data['articles']);
        setState(() {
          technologyNews = articles;
          _loading = false;
        });
      } else {
        throw Exception('Failed to load technology news');
      }
    } catch (e) {
      throw Exception('Failed to connect to the API: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreenUI(
      title: 'Technology',
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                  child: Text(
                    'Technology',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: technologyNews.length,
                    itemBuilder: (context, index) {
                      var article = technologyNews[index];
                      return Newstile(
                        imageUrl: article['image'],
                        title: article['title'],
                        desc: article['description'],
                        source: article['source']['name'],
                        url: article['url'],
                        content: article['content'],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
