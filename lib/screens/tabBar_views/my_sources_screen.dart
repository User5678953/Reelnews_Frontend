import 'package:flutter/material.dart';
import 'package:reel_news/models/article_model.dart';
import 'package:reel_news/services/main_news_fetch.dart';
import 'package:reel_news/widgets/CommonScreenUI.dart';
import 'package:reel_news/widgets/news_source_tile_w_toggle.dart';

class SourceNewsScreen extends StatefulWidget {
  @override
  State<SourceNewsScreen> createState() => _SourceNewsScreenState();
}

class _SourceNewsScreenState extends State<SourceNewsScreen> {
  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  // Fetch news articles and filter them to unique sources
  void getNews() async {
    NewsArticles newsArticlesClass = NewsArticles();
    await newsArticlesClass.getNews();

    Set<String> uniqueSources = Set<String>();
    List<ArticleModel> uniqueArticles = [];

    for (var article in newsArticlesClass.news) {
      if (article.sourceName != null &&
          !uniqueSources.contains(article.sourceName)) {
        uniqueSources.add(article.sourceName!);
        uniqueArticles.add(article);
      }
    }

    setState(() {
      _loading = false;
      articles = uniqueArticles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreenUI(
      title: 'News Sources',
      body: Column(
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
              'MySources',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: _loading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return NewsSourceTileWithToggle(
                          sourceName:
                              articles[index].sourceName ?? 'Unknown Source');
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
