import 'package:flutter/material.dart';
import 'package:reel_news/models/article_model.dart';
import 'package:reel_news/services/main_news_fetch.dart';
import 'package:reel_news/widgets/CommonScreenUI.dart';
import 'package:reel_news/services/my_news_fetch.dart';
import 'package:reel_news/utility/user_source_subscribed_list.dart';
import 'package:reel_news/widgets/NewsTile_Widget.dart';

class MyNewsScreen extends StatefulWidget {
  @override
  _MyNewsScreenState createState() => _MyNewsScreenState();
}

class _MyNewsScreenState extends State<MyNewsScreen> {
  List<ArticleModel> articles = [];
  bool _loading = true;
  final NewsArticles _newsArticles = NewsArticles();

  @override
  void initState() {
    super.initState();
    _fetchAndFilterNews();
  }

  Future<void> _fetchAndFilterNews() async {
    await _newsArticles.getNews(); // Use getNews from NewsArticles
    List<String> subscribedSources =
        UserSourceSubScribedList.getSelectedSources();

    setState(() {
      articles = _newsArticles.news
          .where((article) => subscribedSources.contains(article.sourceName))
          .toList();
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreenUI(
      title: '',
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: articles.length,
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
    );
  }
}
