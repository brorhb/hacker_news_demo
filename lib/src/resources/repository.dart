import 'package:hacker_news/src/models/item_model.dart';
import 'dart:async';
import 'package:hacker_news/src/resources/news_api_provider.dart';
import 'package:hacker_news/src/resources/news_db_provider.dart';

class Repository {

  List<Source> sources = <Source>[
    newsDBProvider,
    NewsApiProvider()
  ];

  List<Cache> caches = <Cache>[
    newsDBProvider
  ];

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    var source;
    var cache;
    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) break;
    }
    for (Cache cahce in caches) {
      if (cache != source) {
        cahce.addItem(item);
      }
    }
    return item;
  }

  Future<List<int>> fetchTopIds() async {
    List<int> ids;
    for (Source source in sources) {
      ids = await source.fetchTopIds();
      if (ids != null) break;
    }
    return ids;
  }

  Future<int> clearCache() async {
    for (Cache cache in caches) {
      await cache.clear();
    }
  }
}

abstract class Source {
  Future<ItemModel> fetchItem(int id);
  Future<List<int>> fetchTopIds();
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}