import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reel_news/models/article_model.dart';

class NewsArticles {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    //String apiKey = 'a579a4147a5089e75fd1164a4d7331e1';

    // Updated URL to the GNews API endpoint
    String url =
        'https://gnews.io/api/v4/search?q=example&lang=en&country=us&max=10&apikey=a579a4147a5089e75fd1164a4d7331e1';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

       if (jsonData['totalArticles'] > 0) {
  jsonData["articles"].forEach((element) {

    // Check for the existence of all fields
    if (element['image'] != null && element['description'] != null) {
      ArticleModel articleModel = ArticleModel(
        title: element['title'],
        description: element['description'],
        url: element['url'],
        urlToImage: element['image'], 
        content: element['content'],
        sourceName: element['source'] != null ? element['source']['name'] : null,
        sourceUrl: element['source'] != null ? element['source']['url'] : null,
      );
      news.add(articleModel);
    }
  });

        }
      } else {
        print('Failed to fetch news. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching news: $e');
    }
  }
}
