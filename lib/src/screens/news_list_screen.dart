import 'package:flutter/material.dart';
import 'package:hacker_news/src/blocs/stories_provider.dart';
import 'package:hacker_news/src/widgets/stories_item.dart';
import 'package:hacker_news/src/widgets/refresh.dart';

class NewsList extends StatelessWidget {
  Widget build(BuildContext context) {
    final StoriesBloc bloc = StoriesProvider.of(context);
    bloc.fetchTopIds();
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News')
      ),
      body: listBuilder(bloc)
    );
  }

  Widget listBuilder (StoriesBloc bloc) {
    return Refresh(
      child: StreamBuilder(
        stream: bloc.topIds,
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot){
          if (snapshot.hasData) {
            return Scrollbar(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  bloc.fetchItem(snapshot.data[index]);
                  return StoriesItem(id: snapshot.data[index]);
                }
              )
            );
          } else return Center(child: CircularProgressIndicator());
        }
      )
    );
  }
}