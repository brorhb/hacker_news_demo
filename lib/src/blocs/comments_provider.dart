import 'package:flutter/material.dart';
import 'package:hacker_news/src/blocs/comments_bloc.dart';

export 'package:hacker_news/src/blocs/comments_bloc.dart';

class CommentsProvider extends InheritedWidget {
  final CommentsBloc bloc;
  CommentsProvider({Key key, this.child})
    : bloc = CommentsBloc(),
      super(key: key, child: child);

  final Widget child;

  static CommentsBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(CommentsProvider) as CommentsProvider).bloc;
  }

  @override
  bool updateShouldNotify( CommentsProvider oldWidget) {
    return true;
  }
}