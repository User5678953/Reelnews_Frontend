import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:reel_news/widgets/CommonScreenUi.dart';
import 'package:reel_news/widgets/NewsTile_Widget.dart';
import 'package:xml/xml.dart'; // For RSS parsing

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

    // Clear the existing business news
    businessNews.clear();

    // Fetch news from GNews API
    await fetchFromGNewsAPI();

    // Fetch news from business-related RSS feeds
    await fetchFromRSSFeed('CNBC', 'https://thingproxy.freeboard.io/fetch/https://www.cnbc.com/id/10001147/device/rss/rss.html');
    await fetchFromRSSFeed('MarketWatch', 'https://thingproxy.freeboard.io/fetch/https://feeds.marketwatch.com/marketwatch/topstories/');

    setState(() {
      _loading = false;
    });
  }

  Future<void> fetchFromGNewsAPI() async {
    final url =
        'https://gnews.io/api/v4/top-headlines?category=business&lang=en&country=us&max=25&apikey=a579a4147a5089e75fd1164a4d7331e1';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<Map<String, dynamic>> articles =
            List<Map<String, dynamic>>.from(data['articles']);
        
        setState(() {
          businessNews.addAll(articles.map((article) {
            return {
              'title': article['title'] ?? 'No title available', // Handling null
              'description': article['description'] ?? 'No description available', // Handling null
              'url': article['url'] ?? '',
              'image': article['image'], // Nullable, it's fine to pass null
              'source': {
                'name': article['source'] != null ? article['source']['name'] ?? 'Unknown source' : 'Unknown source', // Handling null
              },
              'content': article['content'] ?? '', // Handling null
            };
          }).toList());
        });
      } else {
        throw Exception('Failed to load business news');
      }
    } catch (e) {
      throw Exception('Failed to connect to the API: $e');
    }
  }

  Future<void> fetchFromRSSFeed(String sourceName, String rssUrl) async {
    try {
      var response = await http.get(Uri.parse(rssUrl));

      if (response.statusCode == 200) {
        var xmlResponse = XmlDocument.parse(response.body);
        xmlResponse.findAllElements('item').forEach((element) {
          String title = element.findElements('title').isNotEmpty ? element.findElements('title').single.text : 'No title available'; // Handling null
          String description = element.findElements('description').isNotEmpty ? element.findElements('description').single.text : 'No description available'; // Handling null
          String link = element.findElements('link').isNotEmpty ? element.findElements('link').single.text : '';
          String? imageUrl = element.findElements('enclosure').isNotEmpty
              ? element.findElements('enclosure').single.getAttribute('url')
              : null;

          // Add the RSS article to the businessNews list
          setState(() {
            businessNews.add({
              'title': title,
              'description': description,
              'url': link,
              'image': imageUrl, // Nullable, it's fine to pass null
              'source': {'name': sourceName},
              'content': description, // Using description as content placeholder
            });
          });
        });
      } else {
        print('Failed to load RSS feed from $sourceName. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching RSS feed from $sourceName: $e');
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
                        imageUrl: article['image'], // image can be null
                        title: article['title'], // Required, now has fallback value
                        desc: article['description'], // Required, now has fallback value
                        source: article['source']['name'], // Required, now has fallback value
                        url: article['url'], // Required, now has fallback value
                        content: article['content'], // Required, now has fallback value
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
