class News {
  final String title;
  final String urlToImage;
  final String url;

  News({required this.title, required this.urlToImage, required this.url});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      urlToImage: json['urlToImage'],
      url: json['url'],
    );
  }
}
