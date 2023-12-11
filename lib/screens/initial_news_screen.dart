import 'package:flutter/material.dart';
import 'package:reel_news/models/article_model.dart';
import 'package:reel_news/models/category_model.dart';
import 'package:reel_news/screens/tabBar_views/archive_screen.dart';
import 'package:reel_news/screens/tabBar_views/discover_screen.dart';
import 'package:reel_news/screens/tabBar_views/sources_screen.dart';
import 'package:reel_news/services/categories_fetch.dart';
import 'package:reel_news/services/news_fetch.dart';
import 'package:reel_news/widgets/CommonScreenUI.dart';
import 'package:reel_news/widgets/CategoryTile_Widget.dart';
import 'package:reel_news/widgets/NewsTile_Widget.dart';
import 'package:reel_news/screens/auth_views/login_screen.dart';

class InitialNewsScreen extends StatefulWidget {
  @override
  State<InitialNewsScreen> createState() => _InitialNewsScreenState();
}

class _InitialNewsScreenState extends State<InitialNewsScreen> {
  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];
  bool _loading = true;
  int _currentIndex = 0;

  void _onLogout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    categories = getCategories();
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

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
 
  // Handle navigation based on the tapped tab
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ArchiveScreen()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DiscoverScreen()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SourcesScreen()));
        break;
    }
  }



  void _logout() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreenUI(
      title: '',
      body: _loading
          ? Center(child: CircularProgressIndicator())
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
                        //  use CategoryTile_Widget
                        return CategoryTile_Widget(category: categories[index]);
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
      currentIndex: _currentIndex,
      onTabTapped: _onTabTapped,
      onLogout: _onLogout,
    );
  }
}
