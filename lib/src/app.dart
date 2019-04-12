import 'package:flutter/material.dart';
import 'package:hacker_news/src/screens/news_list_screen.dart';
import 'package:hacker_news/src/blocs/stories_provider.dart';
import 'package:hacker_news/src/screens/news_detail.dart';
import 'package:hacker_news/src/blocs/comments_provider.dart';
import 'package:hacker_news/src/models/item_model.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: CommentsProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'News',
          onGenerateRoute: routes
        )
      )
    );
  }
}

Route routes (RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return NewsList();
        }
      );
      break;
    case '/details':
      final ItemModel item = settings.arguments;
      return MaterialPageRoute(
        builder: (BuildContext context) {
          final CommentsBloc commentsBloc = CommentsProvider.of(context);
          commentsBloc.fetchItemWithComments(item.id);
          return NewsDetail(item: item);
        }
      );
      break;
    default:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: Text('Ops!')),
            body: Center(child: Text('404 not found'))
          );
        }
      );
      break;
  }
  /*if (settings.name == '/') {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return NewsList();
      }
    );
  }
  else if (RegExp('\/details\/[0-9]*').firstMatch(settings.name) != null) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return NewsDetail();
      }
    );
  }*/
}