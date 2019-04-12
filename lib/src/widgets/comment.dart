import 'dart:async';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news/src/widgets/placeholder_item_tile.dart';
import 'package:flutter_html/flutter_html.dart';

class Comment extends StatelessWidget {
  final int itemId;
  int level;
  final Map<int, Future<ItemModel>> itemMap;
  Comment({this.itemMap, this.itemId, this.level}) {
    level = this.level ?? 1;
  }
  
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) return PlaceholderTile();
        if (snapshot.data.deleted) return Container(
          margin: EdgeInsets.only(left: getMargin(level ?? 1)),
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 12),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 4, color: getColor(level ?? 1)),
              bottom: BorderSide(width: 1, color: Colors.black26)
            )
          ),
          alignment: Alignment.topLeft,
          child: Text(
            'Deleted',
            style: TextStyle(color: Colors.black45, fontStyle: FontStyle.italic),
          )
        );
        final children = <Widget>[
          Container(
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(width: 4, color: getColor(level ?? 1)),
                bottom: BorderSide(width: 1, color: Colors.black26)
              )
            ),
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(left: getMargin(level ?? 1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Html(data: snapshot.data.text),
                Text('User: ${snapshot.data.by}', style: TextStyle(
                  color: Colors.black45,
                  fontStyle: FontStyle.italic,
                  fontSize: 12
                ))
              ],
            )
          )
        ];

        snapshot.data.kids.forEach((id) {
          children.add(Comment(itemId: id, itemMap: itemMap, level: level + 1));
        });

        return Column(children: children);
      },
    );
  }

  double getMargin(int level) {
    final double base = 4.0;
    if (level == 1) return 0.0;
    if (level == 2) return base;
    if (level == 3) return base*2;
    if (level == 5) return base*3;
    if (level == 6) return base*4;
    else return base*5;
  }

  Color getColor(int level) {
    if (level%3 == 1) return Colors.redAccent;
    if (level%3 == 2) return Colors.cyan;
    if (level%3 == 0) return Colors.amber;
  }
}