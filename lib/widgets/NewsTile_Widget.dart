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
        // Navigate to SingleArticleScreen when tapped
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
          color: Color.fromARGB(255, 131, 131, 131),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: DefaultImage(imageUrl: imageUrl),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 10, 12, 70),
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
                      SizedBox(height: 6), 
                      Text(
                        desc,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        maxLines: 2,
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
            // link button to open the article URL
            Positioned(
              bottom: 8,
              left: 8,
              child: InkWell(
                onTap: () {
                  _launchUrl(url); 
                  // Launch the article URL
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
