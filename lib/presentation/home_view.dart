import 'package:news_apps_petrus/data/datasource.dart';
import 'package:news_apps_petrus/provider/newsprovider.dart';
import 'package:news_apps_petrus/widgets/card_view.dart';
import 'package:news_apps_petrus/widgets/web_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: newsProvider.getNews(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: newsProvider.news.length,
              itemBuilder: (context, index) {
                return CardNews(
                    imagePath: newsProvider.news[index].urlToImage,
                    title: newsProvider.news[index].title,
                    url: newsProvider.news[index].url);
              },
            );
          },
        ),
      ),
    );
  }
}