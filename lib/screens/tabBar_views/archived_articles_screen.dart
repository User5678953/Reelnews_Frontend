import 'package:flutter/material.dart';
import 'package:reel_news/utility/storage_service.dart';
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
  }

  Widget _buildArchivedArticleCard(
      String title, String url, String imageUrl, int index) {
    return Card(
      elevation: 4, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), 
      ),
      margin: EdgeInsets.all(8.0), 
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0), 
        leading: ClipRRect(
          borderRadius:
              BorderRadius.circular(8.0), 
          child: Image.network(
            imageUrl,
            width: 100,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.image, size: 60); 
            },
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          //Truncate Text 
          overflow: TextOverflow.ellipsis, 
          maxLines: 2, 
        ),
        subtitle: Text(
          url,
          style: TextStyle(
            fontSize: 14,
          ),
          overflow: TextOverflow.ellipsis, 
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Material(
                color: Colors.green, 
                child: InkWell(
                  onTap: () => _launchUrl(url),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.chrome_reader_mode_rounded,
                      color: Colors.white,
                      size: 24, 
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.0), 
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Material(
                color: Colors.red, 
                child: InkWell(
                  onTap: () => _deleteArticle(_archivedArticles[index]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.white,
                      size: 24, 
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//Build card
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
            child: _archivedArticles.isEmpty
                ? _noArchivedArticlesWidget(context)
                : ListView.builder(
                    itemCount: _archivedArticles.length,
                    itemBuilder: (context, index) {
                      var articleData = _archivedArticles[index].split(';');
                      // articleData format: [title, url, imageUrl]

                      return _buildArchivedArticleCard(
                        articleData[0], // title
                        articleData[1], // url
                        articleData[2], // imageUrl
                        index,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

//if no Articles build
  Widget _noArchivedArticlesWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0), 
            child: const Text(
              "You haven't archived any articles yet.",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0), 
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/initialNews'),
              child: Text(
                'Go to News',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
