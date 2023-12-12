import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:reel_news/widgets/CommonScreenUi.dart';
import 'package:reel_news/widgets/NewsTile_Widget.dart';

class BusinessScreen extends StatefulWidget {
  @override
  _BusinessScreenState createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  List<Map<String, dynamic>> businessNews = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchBusinessNews();
  }

  Future<void> fetchBusinessNews() async {
    setState(() {
      _loading = true;
    });

    final url =
        'https://gnews.io/api/v4/top-headlines?category=business&lang=en&country=us&max=25&apikey=a579a4147a5089e75fd1164a4d7331e1';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<Map<String, dynamic>> articles =
            List<Map<String, dynamic>>.from(data['articles']);
        setState(() {
          businessNews = articles;
          _loading = false;
        });
      } else {
        throw Exception('Failed to load business news');
      }
    } catch (e) {
      throw Exception('Failed to connect to the API: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreenUI(
      title: 'Business',
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
                  padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
                  child: Text(
                    'Business',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: businessNews.length,
                    itemBuilder: (context, index) {
                      var article = businessNews[index];
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
