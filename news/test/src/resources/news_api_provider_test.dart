import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:news/src/models/item_model.dart';

// cannot do this, because it is outside the lib folder!
//import '../../src/resources/news_api_provider_test.dart';

// must instead import it like a third-party library.
import 'package:news/src/resources/news_api_provider.dart';

void main() {
  test('fetchTopIds returns a list of ids', () async {
    final newsApi = NewsApiProvider();

    // replace the client with the mock client. this will intercept the calls.
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();
    expect(ids, [1, 2, 3, 4]);
  });

  test('fetchItems returns a item model', () async {
    final newsApi = NewsApiProvider();

    // replace the client with the mock client. this will intercept the calls.
    newsApi.client = MockClient((request) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(123);
    expect(item.id, 123);
  });
}
