import 'package:flutter/material.dart';
import 'package:reel_news/models/article_model.dart';
import 'package:reel_news/widgets/CommonScreenUI.dart';
import 'package:url_launcher/url_launcher.dart';

class DefaultImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  DefaultImage({
    required this.imageUrl,
    this.width = double.infinity, 
    this.height = 200, 
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey,
          child: Center(
            child: Icon(Icons.image, size: 50, color: Colors.white),
          ),
        );
      },
    );
  }
}

class SingleArticleScreen extends StatelessWidget {
  final ArticleModel article;

  SingleArticleScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    Future<void> _launchUrl(String url) async {
      final Uri _url = Uri.parse(url);
      if (!await launchUrl(_url)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch $url'),
          ),
        );
      }
    }

    return CommonScreenUI(
      title: article.title ?? 'No Title',
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
                  child: Text(
                    "",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                article.urlToImage != null
                    ? DefaultImage(imageUrl: article.urlToImage!)
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
          Positioned(
           bottom: 5,
            right: 16,
            child: InkWell(
              onTap: () {
                _launchUrl(article.url ?? '');
              },
              child: CircleAvatar(
                backgroundColor: Colors.green,
                radius: 40, 
                child: Icon(Icons.chrome_reader_mode,
                    color: Colors.white, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}