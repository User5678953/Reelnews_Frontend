
import 'package:flutter/material.dart';
import 'package:reel_news/models/article_model.dart';
import 'package:reel_news/models/category_model.dart';
import 'package:reel_news/screens/api_news_screen.dart';
import 'package:reel_news/screens/auth_views/login_screen.dart';
import 'package:reel_news/screens/single_article_screen.dart';
import 'package:reel_news/services/categories_fetch.dart';
import 'package:reel_news/services/news_fetch.dart';

class PublicNewsScreen extends StatefulWidget {
  @override
  State<PublicNewsScreen> createState() => _PublicNewsScreenState();
}

class _PublicNewsScreenState extends State<PublicNewsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void _logout() {
    // Navigate to the login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              LoginScreen()),
    );
  }

  
  
  
  // Initialize an empty list of models
  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();

    // Fetch the news asynchronously.
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () =>
              _scaffoldKey.currentState?.openDrawer(), 
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Reel',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.yellow)),
            Text('News',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue))
          ],
        ),
        actions: <Widget> [
          Container(
            decoration: BoxDecoration(
              color: Colors.red, 
              borderRadius: BorderRadius.circular(8), 
            ),
            margin: EdgeInsets.all(8), 
            child: IconButton(
              icon: Icon(Icons.logout, color: Colors.white), 
              onPressed: _logout,
            ),
          ),
        ],
        elevation: 4.0,
      ),
       drawer: Drawer(
        child: Container(
          color: Colors.grey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              margin: EdgeInsets.zero, 
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.archive),
              title: Text('MyArchive'),
              onTap: () {
                Navigator.pop(context); 
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => APINewsScreen()
                  ),
                );
              },
            ),
                    
          ],
        ),
      ),
    ),

      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: Column(
                children: <Widget>[

                  // CategoryTile
                  Container(
                    padding: EdgeInsets.only(top: 3),
                    height: 100,
                    child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                            imageUrl: categories[index].imageUrl ?? "",
                            categoryName: categories[index].categoryName ?? "",
                           //Fetch the category on tap
                           onTap: () {

                            });
                      },
                    ),
                  ),

                  // News Tile
                  Expanded(
                    child: Container(
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
                              url: articles[index].url ?? 'default_url'
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl;
  final String categoryName;
  final VoidCallback onTap;

  CategoryTile({
    required this.imageUrl,
    required this.categoryName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 175,
        height: 450,
        padding: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Newstile extends StatelessWidget {
  final String imageUrl, title, desc, source, url;

  Newstile({
    required this.imageUrl,
    required this.title,
    required this.desc,
    this.source = '',
    required this.url,
  });

 @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SingleArticleScreen(newsUrl: url),
            ),
          );
        },
    child: Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 236, 238, 240)!.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Text(
                      desc,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (source.isNotEmpty)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  source,
                  style: TextStyle(
                     color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 8,
            right: 8,
            child: InkWell(
              onTap: () {
                // TODO: Add functionality later for archive button
              },
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 30,
                child: Icon(
                  Icons.archive, 
                  color: Colors.white,
                  size: 30),
              ),
            ),
          ),
        ],
      ),
    )
    );
  }
}
