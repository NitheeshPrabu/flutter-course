import 'dart:async';

import 'package:flutter/material.dart';

import './loading_list_tile.dart';
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
      builder: (ctx1, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingListTile();
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (ctx2, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingListTile();
            }

            return buildTile(itemSnapshot.data, ctx2);
          },
        );
      },
    );
  }

  Widget buildTile(ItemModel item, BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(item.title),
          subtitle: Text('${item.score} points'),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text('${item.descendants}'),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, '/${item.id}');
          },
        ),
        Divider(height: 8.0),
      ],
    );
  }
}
