import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:news_api_flutter_package/model/error.dart';
import 'package:news_api_flutter_package/model/source.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';

class APINewsScreen extends StatelessWidget {
  final NewsAPI _newsAPI = NewsAPI("d446e80f75794e569d031dde304a73f2");

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        appBar: AppBar(
          title: Text("Reel News"),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: "Top Headlines"),
              Tab(text: "Everything"),
              Tab(text: "Sources"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildNewsTabView("top-headlines"),
            _buildNewsTabView("everything"),
            _buildSourceTabView(),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsTabView(String category) {
    return FutureBuilder<List<Article>>(
      future: (category == "top-headlines")
          ? _newsAPI.getTopHeadlines(country: "us")
          : _newsAPI.getEverything(query: "bitcoin"),
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Article article = snapshot.data![index];
                return _buildNewsCard(article);
              },
            );
          } else if (snapshot.hasError) {
            return _buildError(snapshot.error as ApiError);
          }
        }
        return _buildProgress();
      },
    );
  }

  Card _buildNewsCard(Article article) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          article.urlToImage != null
              ? Image.network(article.urlToImage!, fit: BoxFit.cover)
              : Container(),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  article.description ?? "",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceTabView() {
    return FutureBuilder<List<Source>>(
      future: _newsAPI.getSources(),
      builder: (BuildContext context, AsyncSnapshot<List<Source>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Source source = snapshot.data![index];
                return ListTile(
                  title: Text(source.name!),
                  subtitle: Text(source.description!),
                );
              },
            );
          } else if (snapshot.hasError) {
            return _buildError(snapshot.error as ApiError);
          }
        }
        return _buildProgress();
      },
    );
  }

  Widget _buildProgress() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildError(ApiError error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error.code ?? "Error",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              error.message!,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
