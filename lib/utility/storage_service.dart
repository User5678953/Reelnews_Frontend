import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // A key used to store/retrieve archived articles from SharedPreferences
  static const String _archivedArticlesKey = 'archivedArticles';

  // Method to archive an article. It saves the article data in SharedPreferences.
  Future<void> archiveArticle(String title, String url, String imageUrl) async {
    // Obtain an instance of SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Retrieve the list of archived articles, if it exists, or initialize an empty list
    List<String> archived = prefs.getStringList(_archivedArticlesKey) ?? [];

    // Create a string that represents the article data
    String articleData = '$title;$url;$imageUrl';

    // Add the article data to the list of archived articles, if it's not already there
    if (!archived.contains(articleData)) {
      archived.add(articleData);

      // Save the updated list of archived articles in SharedPreferences
      await prefs.setStringList(_archivedArticlesKey, archived);
      print('Article saved: $articleData');
    }
  }

  // Method to retrieve all archived articles from SharedPreferences
  Future<List<String>> getArchivedArticles() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_archivedArticlesKey) ?? [];
  }

  // Method to delete a specific article from the list of archived articles
  Future<void> deleteArticle(String articleData) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> archived = prefs.getStringList(_archivedArticlesKey) ?? [];

    // Remove the specified article data from the list
    archived.remove(articleData);

    // Save the updated list of archived articles in SharedPreferences
    await prefs.setStringList(_archivedArticlesKey, archived);
  }

  // Method to check if an article is already archived
  Future<bool> isArticleArchived(String url) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> archived = prefs.getStringList(_archivedArticlesKey) ?? [];

    // Check if the article URL is part of any archived article data
    return archived.any((articleData) => articleData.contains(url));
  }
}

