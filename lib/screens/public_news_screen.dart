import 'package:flutter/material.dart';
import 'package:reel_news/models/article_model.dart';
import 'package:reel_news/models/category_model.dart';
import 'package:reel_news/services/categories_fetch.dart';
import 'package:reel_news/services/news_fetch.dart';

class PublicNewsScreen extends StatefulWidget {
  @override
  State<PublicNewsScreen> createState() => _PublicNewsScreenState();
}

class _PublicNewsScreenState extends State<PublicNewsScreen> {
  // Initialize an empty list of models
  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    NewsArticles newsArticlesClass = NewsArticles();
    await newsArticlesClass.getNews();
    articles = newsArticlesClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 16, 16, 16),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Reel',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.yellow)),
            Text('News',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue))
          ],
        ),
        elevation: 4.0,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                          imageUrl: categories[index].imageUrl ?? "",
                          categoryName: categories[index].categoryName ?? "",
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return Newstile(
                              imageUrl: articles[index].urlToImage ?? '',
                              title: articles[index].title ?? '',
                              desc: articles[index].description ?? '',
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl;
  final String categoryName;
  //final VoidCallback onTap;

  CategoryTile({
    required this.imageUrl,
    required this.categoryName,
    //required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        //onTap: onTap,
        child: Container(
          width: 175,
          height: 450,
          padding: EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Text(
                  categoryName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ),
        ));
  }
}

class Newstile extends StatelessWidget {
  final String imageUrl, title, desc;

  Newstile({required this.imageUrl, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Image.network(imageUrl),
        Text(title),
        Text(desc),
      ]),
    );
  }
}
