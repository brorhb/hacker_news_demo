import 'package:http/http.dart' show Client;
import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/resources/repository.dart';
import 'dart:convert';
import 'dart:async';

final String _baseUrl = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();

  Future<List<int>> fetchTopIds () async {
    final response = await client.get(_baseUrl + '/topstories.json');
    final List<dynamic> ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem (int id) async {
    final response = await client.get(_baseUrl + '/item/$id.json');
    final ItemModel item = ItemModel.fromJson(json.decode(response.body));
    return item;
  }
}