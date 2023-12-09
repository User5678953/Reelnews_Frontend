import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reel_news/models/article_model.dart';

class NewsArticles {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        'https://reelnews-api-fe5e8d8c10e8.herokuapp.com/news/top-headlines/?category=general&language=en&country=us';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        if (jsonData['status'] == "ok") {
          jsonData["articles"].forEach((element) {
            if (element['urlToImage'] != null &&
                element['description'] != null) {
              ArticleModel articleModel = ArticleModel(
                title: element['title'],
                author: element['author'],
                description: element['description'],
                url: element['url'],
                urlToImage: element['urlToImage'], 
                content: element['content'],
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
