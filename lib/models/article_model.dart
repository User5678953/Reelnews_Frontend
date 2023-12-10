class ArticleModel {
  String? title;
  String? description;
  String? content;
  String? url;
  String? urlToImage;
  String? sourceName;
  String? sourceUrl;

  ArticleModel({
    this.title,
    this.description,
    this.content,
    this.url,
    this.urlToImage,
    this.sourceName,
    this.sourceUrl,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'],
      description: json['description'],
      content: json['content'],
      url: json['url'],
      urlToImage: json['image'], 
      sourceName: json['source']['name'],
      sourceUrl: json['source']['url'],
    );
  }
}
