import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';


void main () async {
  test('topItems returns List<int>', () async {
    final NewsApiProvider provider = NewsApiProvider();
    provider.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4, 5]), 200);
    });

    final List<int> ids = await provider.fetchTopIds();
    final List<int> exptected = List<int>.generate(5, (int i) => i + 1);
    expect(ids, exptected);
  });
}