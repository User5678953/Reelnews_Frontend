import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:xml/xml.dart' as xml;
import 'package:reel_news/widgets/CommonScreenUI.dart';
import 'package:reel_news/widgets/NewsTile_Widget.dart';

class WorldScreen extends StatefulWidget {
  @override
  _WorldScreenState createState() => _WorldScreenState();
}

class _WorldScreenState extends State<WorldScreen> {
  List<Map<String, dynamic>> worldNews = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchWorldNews();
  }

  Future<void> fetchWorldNews() async {
    setState(() {
      _loading = true;
    });

    // Fetch world news from GNews API
    await fetchFromGNewsAPI();

    // Fetch world news from multiple RSS feeds
    await fetchFromRSSFeed('BBC World', 'https://thingproxy.freeboard.io/fetch/http://feeds.bbci.co.uk/news/world/rss.xml');
    await fetchFromRSSFeed('NY Times World', 'https://thingproxy.freeboard.io/fetch/https://rss.nytimes.com/services/xml/rss/nyt/World.xml');
    await fetchFromRSSFeed('Reuters World', 'https://thingproxy.freeboard.io/fetch/https://www.reutersagency.com/feed/?best-regions=global&post_type=best');
    await fetchFromRSSFeed('Al Jazeera World', 'https://thingproxy.freeboard.io/fetch/https://www.aljazeera.com/xml/rss/all.xml');

    setState(() {
      _loading = false;
    });
  }

  // Fetch GNews API for world news
  Future<void> fetchFromGNewsAPI() async {
    final url =
        'https://gnews.io/api/v4/top-headlines?category=world&lang=en&country=us&max=25&apikey=a579a4147a5089e75fd1164a4d7331e1';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<Map<String, dynamic>> articles =
            List<Map<String, dynamic>>.from(data['articles']);
        
        // Add GNews articles to worldNews list
        articles.forEach((article) {
          worldNews.add({
            'title': article['title'],
            'description': article['description'],
            'url': article['url'],
            'image': article['image'],
            'source': article['source']['name'],
            'content': article['content'],
          });
        });
      } else {
        throw Exception('Failed to load world news from GNews');
      }
    } catch (e) {
      print('Error fetching world news from GNews API: $e');
    }
  }

  // Fetch from RSS Feeds for world news
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

          // Add RSS article to worldNews list
          worldNews.add({
            'title': title,
            'description': description,
            'url': link,
            'image': imageUrl,
            'source': sourceName,
            'content': description,
          });
        });

        print('Successfully fetched world news from $sourceName');
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
      title: 'World',
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
                  padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                  child: Text(
                    'World',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: worldNews.length,
                    itemBuilder: (context, index) {
                      var article = worldNews[index];
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
