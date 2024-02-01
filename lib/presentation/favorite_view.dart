import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../widgets/web_view.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Box<Map> bookmarkBox = Hive.box<Map>('favorites');
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite News'),
      ),
      body: BookmarkList(),
    );
  }
}

class BookmarkList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Box<Map> bookmarkBox = Hive.box<Map>('favorites');

    return ValueListenableBuilder(
      valueListenable: bookmarkBox.listenable(),
      builder: (context, Box<Map> box, _) {
        return ListView.separated(
          itemCount: box.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            Map bookmark = box.getAt(index)!;
            return ListTile(
              title: Text(bookmark['title']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WebViewContainer(url: bookmark['url']),
                  ),
                );
              },
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Delete the item from the favorites list
                  box.deleteAt(index);
                },
              ),
            );
          },
        );
      },
    );
  }
}
