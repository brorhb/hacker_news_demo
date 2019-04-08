import 'package:flutter/material.dart';
import 'package:hacker_news/src/screens/news_list_screen.dart';
import 'package:hacker_news/src/blocs/stories_provider.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News',
        home: NewsList()
      )
    );
  }
}