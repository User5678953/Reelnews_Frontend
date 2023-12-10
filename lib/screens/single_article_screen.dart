import 'package:flutter/material.dart';
import 'package:reel_news/models/article_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleArticleScreen extends StatelessWidget {
  final ArticleModel article;

  SingleArticleScreen({required this.article});

  // Function to launch URL 
  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          article.title ?? 'No Title',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
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
            SizedBox(height: 10),
            if (article.url != null)
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    primary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text('Read Full Article'),
                  onPressed: () => _launchUrl(article.url!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
