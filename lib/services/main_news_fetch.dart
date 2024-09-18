import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reel_news/models/article_model.dart';
import 'package:xml/xml.dart' as xml;

class NewsArticles {
  List<ArticleModel> news = [];

  // Fetch GNews API with success message
  Future<void> fetchFromGNewsAPI() async {
    String url =
        'https://gnews.io/api/v4/top-headlines?category=general&lang=en&country=us&max=25&apikey=a579a4147a5089e75fd1164a4d7331e1';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        if (jsonData['totalArticles'] > 0) {
          jsonData["articles"].forEach((element) {
            if (element['image'] != null && element['description'] != null) {
              ArticleModel articleModel = ArticleModel(
                title: element['title'],
                description: element['description'],
                url: element['url'],
                urlToImage: element['image'],
                content: element['content'],
                sourceName: element['source'] != null
                    ? element['source']['name']
                    : null,
                sourceUrl:
                    element['source'] != null ? element['source']['url'] : null,
              );
              news.add(articleModel);
            }
          });
        }

        // Print success message for GNews API
        print('Successfully fetched news from GNews API');
      } else {
        print(
            'Failed to fetch news from GNews. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching news from GNews API: $e');
    }
  }

  // Fetch from RSS Feeds with success message
  Future<void> fetchFromRSSFeed(String sourceName, String rssUrl) async {
    try {
      var response = await http.get(Uri.parse(rssUrl));
      if (response.statusCode == 200) {
        try {
          var xmlResponse =
              xml.XmlDocument.parse(response.body); // Catch malformed XML
          xmlResponse.findAllElements('item').forEach((element) {
            String title = element.findElements('title').single.text;
            String description =
                element.findElements('description').single.text;
            String link = element.findElements('link').single.text;

            // Check for <enclosure> or other image tags
            String? imageUrl = element.findElements('enclosure').isNotEmpty
                ? element.findElements('enclosure').single.getAttribute('url')
                : null;

            // Convert RSS data into the existing ArticleModel structure
            ArticleModel articleModel = ArticleModel(
              title: title,
              description: description,
              url: link,
              urlToImage: imageUrl, // RSS image, if available
              content:
                  description, // RSS content is typically in the description
              sourceName: sourceName, // Dynamic source name
              sourceUrl: link,
            );

            news.add(articleModel);
          });

          // Print success message for each RSS feed
          print('Successfully fetched news from $sourceName');
        } catch (e) {
          print('Malformed XML in feed from $sourceName: $e');
        }
      } else {
        print(
            'Failed to load RSS feed from $sourceName. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching RSS feed from $sourceName: $e');
    }
  }

  // Use the `getNews` function to fetch news from multiple sources
  Future<void> getNews() async {

// Fetch GNews API first
    await fetchFromGNewsAPI();

    // Fetch news from multiple RSS feeds
    await fetchFromRSSFeed('BBC News',
        'https://thingproxy.freeboard.io/fetch/http://feeds.bbci.co.uk/news/rss.xml');
    await fetchFromRSSFeed('NY Times World',
        'https://thingproxy.freeboard.io/fetch/https://rss.nytimes.com/services/xml/rss/nyt/World.xml');

    // Technology News Feeds
    await fetchFromRSSFeed('TechCrunch',
        'https://thingproxy.freeboard.io/fetch/https://techcrunch.com/feed/');
    await fetchFromRSSFeed('Wired Technology',
        'https://thingproxy.freeboard.io/fetch/https://www.wired.com/feed/rss');
    await fetchFromRSSFeed('Ars Technica',
        'https://thingproxy.freeboard.io/fetch/https://feeds.arstechnica.com/arstechnica/index/');

    // Entertainment News Feeds
    await fetchFromRSSFeed('Rolling Stone',
        'https://thingproxy.freeboard.io/fetch/https://www.rollingstone.com/feed/');
    await fetchFromRSSFeed('The Verge Entertainment',
        'https://thingproxy.freeboard.io/fetch/https://www.theverge.com/rss/index.xml');

    // Health News Feeds
    await fetchFromRSSFeed('Mayo Clinic',
        'https://thingproxy.freeboard.io/fetch/https://newsnetwork.mayoclinic.org/feed/');

    // Sports News Feeds
    await fetchFromRSSFeed('ESPN',
        'https://thingproxy.freeboard.io/fetch/https://www.espn.com/espn/rss/news');
    await fetchFromRSSFeed('BBC Sport',
        'https://thingproxy.freeboard.io/fetch/http://feeds.bbci.co.uk/sport/rss.xml');
  }

  // Add more sources as needed...
}
