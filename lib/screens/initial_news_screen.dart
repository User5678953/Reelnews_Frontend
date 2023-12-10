import 'package:flutter/material.dart';
import 'package:reel_news/models/article_model.dart';
import 'package:reel_news/models/category_model.dart';
import 'package:reel_news/services/categories_fetch.dart';
import 'package:reel_news/services/news_fetch.dart';
import 'package:reel_news/widgets/AppBar_Widget.dart';
import 'package:reel_news/widgets/CategoryTile_Widget.dart';
import 'package:reel_news/widgets/NewsTile_Widget.dart';
import 'package:reel_news/widgets/BottomTabbar_Widget.dart';
import 'package:reel_news/screens/auth_views/login_screen.dart';
import 'package:reel_news/screens/tabBar_views/archive_screen.dart';
import 'package:reel_news/screens/tabBar_views/discover_screen.dart';
import 'package:reel_news/screens/tabBar_views/sources_screen.dart';

class InitialNewsScreen extends StatefulWidget {
  @override
  State<InitialNewsScreen> createState() => _InitialNewsScreenState();
}

class _InitialNewsScreenState extends State<InitialNewsScreen> {
  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];
  bool _loading = true;
  int _currentIndex = 0;

  void _logout() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  // Function to handle category tap
  void handleCategoryTap(CategoryModel category) {
  
    // TEST navigate to ArchiveScreen 
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArchiveScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(onMenuTap: () {}, onLogout: _logout),
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
                        return GestureDetector(
                          onTap: () {
                            // Handle the category tap
                            handleCategoryTap(categories[index]);
                          },
                          child: CategoryTileWidget(
                            imageUrl: categories[index].imageUrl ?? "",
                            categoryName: categories[index].categoryName ?? "",
                          ),
                        );
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
                          source: articles[index].source ?? '',
                          url: articles[index].url ?? 'default_url',
                          content: articles[index].content ?? '',
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomTabbarWidget(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }
}
