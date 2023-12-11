import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reel_news/screens/auth_views/login_screen.dart';
import 'dart:convert';

import 'package:reel_news/widgets/CommonScreenUI.dart';
import 'package:reel_news/widgets/NewsTile_Widget.dart';

class EntertainmentScreen extends StatefulWidget {
  @override
  _EntertainmentScreenState createState() => _EntertainmentScreenState();
}

class _EntertainmentScreenState extends State<EntertainmentScreen> {
  List<Map<String, dynamic>> entertainmentNews = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchEntertainmentNews();
  }

  Future<void> fetchEntertainmentNews() async {
    setState(() {
      _loading = true;
    });

    final url =
        'https://gnews.io/api/v4/top-headlines?category=entertainment&lang=en&country=us&max=10&apikey=a579a4147a5089e75fd1164a4d7331e1';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<Map<String, dynamic>> articles =
            List<Map<String, dynamic>>.from(data['articles']);
        setState(() {
          entertainmentNews = articles;
          _loading = false;
        });
      } else {
        throw Exception('Failed to load entertainment news');
      }
    } catch (e) {
      throw Exception('Failed to connect to the API: $e');
    }
  }

  void _onLogout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreenUI(
      title: 'Entertainment',
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
                    'Entertainment',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: entertainmentNews.length,
                    itemBuilder: (context, index) {
                      var article = entertainmentNews[index];
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
      currentIndex: 0,
      onTabTapped: (index) {},
      onLogout: _onLogout,
    );
  }
}
