import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SingleArticleScreen extends StatefulWidget {
  final String newsUrl;

  SingleArticleScreen({required this.newsUrl});

  @override
  _SingleArticleScreenState createState() => _SingleArticleScreenState();
}

class _SingleArticleScreenState extends State<SingleArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article View'),
      ),
      body: WebView(
        initialUrl: widget.newsUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
