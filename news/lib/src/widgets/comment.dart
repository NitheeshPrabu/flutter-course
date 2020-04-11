import 'dart:async';

import 'package:flutter/material.dart';

import '../models/item_model.dart';
import '../widgets/loading_list_tile.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment(this.itemId, this.itemMap, this.depth);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (ctx, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingListTile();
        }

        final item = snapshot.data;
        final children = <Widget>[
          ListTile(
            title: buildText(item.text),
            subtitle: Text(item.by == '' ? 'Deleted comment' : item.by),
            contentPadding: EdgeInsets.only(
              left: (depth + 1) * 16.0,
              right: 16.0,
            ),
          ),
          Divider(),
        ];
        item.kids.forEach((kidId) {
          children.add(
            Comment(
              kidId,
              itemMap,
              depth + 1,
            ),
          );
        });
        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildText(String text) {
    final formattedText = text
        .replaceAll('&#x27;', "'")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '')
        .replaceAll('<i>', '')
        .replaceAll('</i>', '')
        .replaceAll('&#x2F;', '/')
        .replaceAll('&quot;', '"')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>');
    return Text(formattedText);
  }
}
