import 'package:flutter/material.dart';
import 'package:reel_news/Dev/storage_service.dart';
import 'package:reel_news/widgets/CommonScreenUI.dart';
import 'package:url_launcher/url_launcher.dart';

class ArchivedArticlesScreen extends StatefulWidget {
  @override
  _ArchivedArticlesScreenState createState() => _ArchivedArticlesScreenState();
}

class _ArchivedArticlesScreenState extends State<ArchivedArticlesScreen> {
  final StorageService _storageService = StorageService();
  List<String> _archivedArticles = [];

  @override
  void initState() {
    super.initState();
    _loadArchivedArticles();
  }

  Future<void> _loadArchivedArticles() async {
    var archivedArticles = await _storageService.getArchivedArticles();
    print('Loaded articles: $archivedArticles');
    setState(() {
      _archivedArticles = archivedArticles;
    });
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      print('Could not launch $url');
    }
  }

  void _deleteArticle(String articleData) async {
    await _storageService.deleteArticle(articleData);
    _loadArchivedArticles(); 
    // Refresh the list after deletion
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreenUI(
      title: 'Archived Articles',
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
            child: Text(
              'MyArchives',
              style: TextStyle(fontSize: 24.0, color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _archivedArticles.length,
              itemBuilder: (context, index) {
                var articleData = _archivedArticles[index].split(';');
                // articleData format: [title, url, imageUrl]

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    leading: Image.network(
                      articleData[2], // imageUrl
                      width: 100,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.image, size: 60); // Default icon
                      },
                    ),
                    title: Text(articleData[0]), // title
                    subtitle: Text(articleData[1]), // url
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.chrome_reader_mode_rounded, color: Colors.green),
                          onPressed: () => _launchUrl(articleData[1]),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_forever_rounded, color: Colors.red),
                          onPressed: () =>
                              _deleteArticle(_archivedArticles[index]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
