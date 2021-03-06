import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/resources/repository.dart';

class CommentsBloc {
  Repository _repository = Repository();
  final PublishSubject<int> _commentsFetcher = PublishSubject<int>();
  final BehaviorSubject<Map<int, Future<ItemModel>>> _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  Observable<Map<int, Future<ItemModel>>> get itemWithComments => _commentsOutput.stream;
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream.transform(_commentsTransformer()).pipe(_commentsOutput);
  }

  ScanStreamTransformer<int, Map<int, Future<ItemModel>>> _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (Map<int, Future<ItemModel>> cache, int id, int index) {
        cache[id] = _repository.fetchItem(id);
        cache[id].then((ItemModel item) {
          item.kids.forEach((childId) {
            fetchItemWithComments(childId);
          });
        });
        return cache;
      }, <int, Future<ItemModel>>{}
    );
  }

  void dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}