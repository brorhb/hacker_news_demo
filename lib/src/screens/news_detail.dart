import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/blocs/comments_provider.dart';
import 'package:hacker_news/src/widgets/comment.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatelessWidget {
  final ItemModel item;
  NewsDetail({this.item});
  Widget build(BuildContext context) {
    final CommentsBloc commentsBloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: buildBody(commentsBloc)
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments ,
      builder: (BuildContext context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot){
        if (snapshot.hasData) {
          /*return FutureBuilder(
            future: snapshot.data[item.id],
            builder: (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (itemSnapshot.hasData) {
                return Text(itemSnapshot.data.title);
              } else return Container();
            }
          );*/
          return buildList(item: item, map: snapshot.data );
        } else return Center(child: CircularProgressIndicator());
      }
    );
  }

  Widget buildList({ItemModel item, Map<int, Future<ItemModel>> map}) {
    final List<Widget> commentsList = item.kids.map((id) {
      return Comment(itemId: id, itemMap: map);
    }).toList();
    final List<Widget> children = <Widget>[];
    children.add(buildTitle(item));
    children.addAll(commentsList);
    return ListView(
      children: children
    );
  }

  List<Widget> commentsList(Map<int, Future<ItemModel>> map) {
    return <Widget>[];
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item.title,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(item.text ?? ''),
          Material(
            elevation: 2,
            child: InkWell(
              onTap: () {_launchUrl(item.url);},
              child: Container(
                padding: EdgeInsets.all(8),
                child: Text(item.url ?? ''),
              ),
            ),
          )
        ],
      )
    );
  }

  Future<void> _launchUrl(String url) async {
    print(url);
    if (await canLaunch(url)) {
      try {
        await launch(url);
      } catch (err) {}
    } else {
      print('cannot launch url');
    }
  }
}