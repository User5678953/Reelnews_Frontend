import 'package:flutter/material.dart';
import 'package:reel_news/models/article_model.dart';
import 'package:reel_news/screens/auth_views/login_screen.dart';
import 'package:reel_news/widgets/CommonScreenUI.dart'; 

class SingleArticleScreen extends StatelessWidget {
  final ArticleModel article;

  SingleArticleScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    void _onLogout() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }

    return CommonScreenUI(
      title: article.title ?? 'No Title',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            article.urlToImage != null
                ? Image.network(article.urlToImage!)
                : Container(
                    height: 200,
                    color: Colors.grey,
                    child: Center(child: Text('No Image Available')),
                  ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                article.content ?? 'No Content',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      currentIndex: 0,
      onTabTapped: (index) {},
      onLogout: _onLogout,
    );
  }
}
