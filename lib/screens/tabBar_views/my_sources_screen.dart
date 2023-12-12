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

  void getNews() async {
    NewsArticles newsArticlesClass = NewsArticles();
    await newsArticlesClass.getNews();
    articles = newsArticlesClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreenUI(
      title: 'News Sources',
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return NewsSourceTileWithToggle(
                    sourceName: articles[index].sourceName ?? 'Unknown Source');
              },
            ),
    );
  }
}
