import 'package:rxdart/rxdart.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/resources/repository.dart';
import 'dart:async';

class StoriesBloc {
  final Repository _repository = Repository();
  final PublishSubject<List<int>> _topIds = PublishSubject<List<int>>();
  final BehaviorSubject<Map<int, Future<ItemModel>>> _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final PublishSubject<int> _itemsFetcher = PublishSubject<int>();

  Observable<List<int>> get topIds => _topIds.stream;
  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  Future<void> fetchTopIds () async {
    final List<int> ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  Future<int> clearCache() {
    return _repository.clearCache();
  }

  ScanStreamTransformer<int, Map<int, Future<ItemModel>>> _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, int index) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{}
    );
  }

  void dispose () {
    _topIds.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  }
}