import 'package:flutter/material.dart';
import 'package:hacker_news/src/blocs/stories_provider.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'dart:async';
import 'package:hacker_news/src/widgets/placeholder_item_tile.dart';
import 'package:hacker_news/src/widgets/news_item_tile.dart';

class StoriesItem extends StatelessWidget {
  final int id;
  StoriesItem({Key key, this.id}) : super(key: key);
  
  Widget build(BuildContext context) {
    final StoriesBloc bloc = StoriesProvider.of(context);
    return StreamBuilder(
      stream: bloc.items,
      builder: (BuildContext context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) return PlaceholderTile();
        else return FutureBuilder(
          future: snapshot.data[id],
          builder: (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!snapshot.hasData) return PlaceholderTile();
            else return NewsItemTile(item: itemSnapshot.data);
          },
        );
      }
    );
  }
}