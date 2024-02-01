import 'package:news_apps_petrus/data/datasource.dart';
import 'package:news_apps_petrus/data/repositories.dart';
import 'package:news_apps_petrus/model/news.dart';
import 'package:news_apps_petrus/presentation/favorite_view.dart';
import 'package:news_apps_petrus/presentation/home_view.dart';
import 'package:news_apps_petrus/provider/newsprovider.dart';
import 'package:flutter/material.dart';
import 'package:news_apps_petrus/main.dart';
import 'package:provider/provider.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('BSI News'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home), text: 'Home'),
                Tab(icon: Icon(Icons.star), text: 'Favorite'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              HomeView(),
              FavoriteView(),
            ],
          ),
        ),
      ),
    );
  }
}
