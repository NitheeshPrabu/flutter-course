import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_provider.dart';

class RefreshList extends StatelessWidget {
  final Widget child;

  RefreshList(this.child);

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
    );
  }
}
