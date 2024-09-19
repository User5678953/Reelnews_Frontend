import 'package:flutter/material.dart';
import 'package:reel_news/models/article_model.dart';
import 'package:reel_news/models/category_model.dart';
import 'package:reel_news/services/categories_fetch.dart';
import 'package:reel_news/services/main_news_fetch.dart';
import 'package:reel_news/widgets/CommonScreenUI.dart';
import 'package:reel_news/widgets/CategoryTile_Widget.dart';
import 'package:reel_news/widgets/NewsTile_Widget.dart';
import 'package:http/http.dart' as http;


class InitialNewsScreen extends StatefulWidget {
  @override
  State<InitialNewsScreen> createState() => _InitialNewsScreenState();
}

class _InitialNewsScreenState extends State<InitialNewsScreen> {
  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];
  bool _loading = true;
  bool _error = false; // Track error state
  int? _statusCode;    // Store status code for error

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

void getNews() async {
  NewsArticles newsArticlesClass = NewsArticles();
  
  try {
    await newsArticlesClass.getNews();
    setState(() {
      articles = newsArticlesClass.news;
      _loading = false;
      _error = false; // Reset error on success
      _statusCode = null; // Clear status code on success
    });
  } catch (e) {
    if (e is http.ClientException) {
      setState(() {
        _statusCode = 500; // Default to 500 if no specific status code
        _error = true;
        _loading = false;
      });
    } else {
      setState(() {
        _statusCode = null; // No status code for other exceptions
        _error = true;
        _loading = false;
      });
    }
    print("Error fetching news: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return CommonScreenUI(
      title: '',
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _error // Show error message if there's an error
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, color: Colors.red, size: 60),
                      SizedBox(height: 10),
                      Text(
                        _statusCode != null
                            ? 'Failed to load news (Error: $_statusCode).'
                            : 'Failed to load news. Please try again later.',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      if (_statusCode == 403)
                        Text(
                          'You have reached the API limit. Please try again tomorrow.',
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      if (_statusCode == 500)
                        Text(
                          'Internal server error. Please try again later.',
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: getNews, // Retry button
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                )
              : Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 3),
                        height: 100,
                        child: ListView.builder(
                          itemCount: categories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CategoryTile_Widget(
                                category: categories[index]);
                          },
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: articles.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Newstile(
                              imageUrl: articles[index].urlToImage ?? '',
                              title: articles[index].title ?? '',
                              desc: articles[index].description ?? '',
                              source: articles[index].sourceName ?? '',
                              url: articles[index].url ?? 'default_url',
                              content: articles[index].content ?? '',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}

