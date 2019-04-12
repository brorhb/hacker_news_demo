import 'package:flutter/material.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/widgets/placeholder_item_tile.dart';

class NewsItemTile extends StatelessWidget {
  final ItemModel item;

  NewsItemTile({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item == null) return PlaceholderTile();
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed('/details', arguments: item);
          },
          title: Text(item.title),
          subtitle: Text('${item.score} upvotes'),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text(item.kids.length.toString())
            ],
          )
        ),
        Divider()
      ],
    );
  }
}