import 'dart:convert';

import 'package:news_apps_petrus/data/datasource.dart';
import 'package:news_apps_petrus/model/news.dart';

class Repository {
  final DataSource _dataSource;

  Repository(this._dataSource);

  Future<List<News>> getNews() async {
    List<News> newsList = [];
    var a = await _dataSource.getNews();
    var c = jsonDecode(a!) as Map<String, dynamic>;
    var b = c!['articles'] as List<dynamic>;

    newsList = b.map((e) => News.fromJson(e)).toList();
    return newsList;
  }
}
