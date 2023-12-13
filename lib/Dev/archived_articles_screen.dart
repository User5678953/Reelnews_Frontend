import 'package:flutter/material.dart';
import 'package:reel_news/Dev/storage_service.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Archived Articles'),
      ),
      body: ListView.builder(
        itemCount: _archivedArticles.length,
        itemBuilder: (context, index) {
          var articleData = _archivedArticles[index].split(';');
          return ListTile(
            title: Text(articleData[0]),
            subtitle: Text(articleData[1]),
            onTap: () => _launchUrl(articleData[1]),
          );
        },
      ),
    );
  }
}
