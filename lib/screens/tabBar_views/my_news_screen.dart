import 'package:flutter/material.dart';
import 'package:reel_news/models/article_model.dart';
import 'package:reel_news/services/main_news_fetch.dart';
import 'package:reel_news/utility/user_source_subscribed_list.dart';
import 'package:reel_news/widgets/CommonScreenUI.dart';
import 'package:reel_news/widgets/NewsTile_Widget.dart';

class MyNewsScreen extends StatefulWidget {
  @override
  _MyNewsScreenState createState() => _MyNewsScreenState();
}

class _MyNewsScreenState extends State<MyNewsScreen> {
  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchAndFilterNews();
  }

  void _fetchAndFilterNews() async {
    NewsArticles newsArticlesClass = NewsArticles();
    await newsArticlesClass.getNews();
    List<String> subscribedSources =
        UserSourceSubScribedList.getSelectedSources();

    setState(() {
      _loading = false;
      articles = newsArticlesClass.news
          .where((article) => subscribedSources.contains(article.sourceName))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> subscribedSources =
        UserSourceSubScribedList.getSelectedSources();

    return CommonScreenUI(
      title: 'My News',
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : subscribedSources.isEmpty
              ? _noSubscribedSourcesWidget(context)
              : ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return Newstile(
                      imageUrl: articles[index].urlToImage ?? '',
                      title: articles[index].title ?? '',
                      desc: articles[index].description ?? '',
                      source: articles[index].sourceName ?? '',
                      url: articles[index].url ?? '',
                      content: articles[index].content ?? '',
                    );
                  },
                ),
    );
  }

  Widget _noSubscribedSourcesWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "You haven't subscribed to any sources yet.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white)
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(
                context, '/sources'), 
            child: Text('Go to MySources', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(primary: Colors.blue),
          ),
        ],
      ),
    );
  }
}
