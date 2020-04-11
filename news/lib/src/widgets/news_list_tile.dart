import 'dart:async';

import 'package:flutter/material.dart';

import '../models/item_model.dart';
import '../blocs/stories_provider.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile(this.itemId);

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (ctx, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text('loading');
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (ctx, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text('$itemId loading');
            }

            return Text('${itemSnapshot.data.title}');
          },
        );
      },
    );
  }
}
