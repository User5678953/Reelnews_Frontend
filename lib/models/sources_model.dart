class NewsSource {
  final String name;
  final String url;

  NewsSource({required this.name, required this.url});

  factory NewsSource.fromJson(Map<String, dynamic> json) {
    return NewsSource(
      name: json['source']['name'] as String,
      url: json['source']['url'] as String,
    );
  }
}
