import 'package:flutter/material.dart';
import 'package:reel_news/models/article_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:reel_news/screens/single_article_screen.dart';

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

class Newstile extends StatelessWidget {
  final String imageUrl, title, desc, source, url, content;

  Newstile({
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.source,
    required this.url,
    required this.content,
  });

  // Function to launch URL
  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleArticleScreen(
                article: ArticleModel(
              title: title,
              content: content,
              urlToImage: imageUrl,
              url: url,
            )),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 236, 238, 240).withOpacity(0.5),
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
                  child: DefaultImage(imageUrl: imageUrl),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 24, // title
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 30),
                      Text(
                        desc,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        maxLines: 1, 
                        overflow: TextOverflow.ellipsis,
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
                  print('Archive button tapped for article: $title');
                  // TODO: Implement archive functionality
                },
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 30,
                  child: Icon(Icons.archive, color: Colors.white, size: 30),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              child: InkWell(
                onTap: () {
                  _launchUrl(url);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 30,
                  child: Icon(Icons.chrome_reader_mode,
                      color: Colors.white, size: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
