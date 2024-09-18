import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reel_news/widgets/CommonScreenUi.dart';
import 'dart:convert';
import 'package:xml/xml.dart' as xml;
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

    // Fetch entertainment news from GNews API
    await fetchFromGNewsAPI();

    // Fetch entertainment news from RSS feeds
    await fetchFromRSSFeed('Rolling Stone', 'https://thingproxy.freeboard.io/fetch/https://www.rollingstone.com/feed/');
    await fetchFromRSSFeed('The Verge Entertainment', 'https://thingproxy.freeboard.io/fetch/https://www.theverge.com/rss/index.xml');
    await fetchFromRSSFeed('MTV News', 'https://thingproxy.freeboard.io/fetch/https://www.mtv.com/news/rss.xml');

    setState(() {
      _loading = false;
    });
  }

  // Fetch GNews API for entertainment news
  Future<void> fetchFromGNewsAPI() async {
    final url =
        'https://gnews.io/api/v4/top-headlines?category=entertainment&lang=en&country=us&max=25&apikey=a579a4147a5089e75fd1164a4d7331e1';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<Map<String, dynamic>> articles =
            List<Map<String, dynamic>>.from(data['articles']);
        
        // Add GNews articles to entertainmentNews list
        articles.forEach((article) {
          entertainmentNews.add({
            'title': article['title'],
            'description': article['description'],
            'url': article['url'],
            'image': article['image'],
            'source': article['source']['name'],
            'content': article['content'],
          });
        });
      } else {
        throw Exception('Failed to load entertainment news from GNews');
      }
    } catch (e) {
      print('Error fetching entertainment news from GNews API: $e');
    }
  }

  // Fetch from RSS Feeds for entertainment news
  Future<void> fetchFromRSSFeed(String sourceName, String rssUrl) async {
    try {
      final response = await http.get(Uri.parse(rssUrl));
      if (response.statusCode == 200) {
        final xmlResponse = xml.XmlDocument.parse(response.body);

        // Parse RSS feed items
        xmlResponse.findAllElements('item').forEach((element) {
          String title = element.findElements('title').single.text;
          String description = element.findElements('description').single.text;
          String link = element.findElements('link').single.text;

          // Check for <enclosure> or other image tags
          String? imageUrl = element.findElements('enclosure').isNotEmpty
              ? element.findElements('enclosure').single.getAttribute('url')
              : null;

          // Add RSS article to entertainmentNews list
          entertainmentNews.add({
            'title': title,
            'description': description,
            'url': link,
            'image': imageUrl,
            'source': sourceName,
            'content': description,
          });
        });

        print('Successfully fetched entertainment news from $sourceName');
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
                        source: article['source'],
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
