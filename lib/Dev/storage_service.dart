import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _archivedArticlesKey = 'archivedArticles';

  Future<void> archiveArticle(String title, String url, String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> archived = prefs.getStringList(_archivedArticlesKey) ?? [];
    String articleData = '$title;$url;$imageUrl';
    archived.add(articleData);
    await prefs.setStringList(_archivedArticlesKey, archived);
    print('Article saved: $articleData');
  }

  Future<List<String>> getArchivedArticles() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_archivedArticlesKey) ?? [];
  }
}
