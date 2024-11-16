import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/app_state.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
        backgroundColor: theme.colorScheme.primary);

    var favorites = appState.favorites
        .map((m) => ListTile(
            leading: IconButton.outlined(
                onPressed: () {
                  print('removing favorite:${m.asLowerCase}');
                  appState.removeFavorite(m);
                },
                icon: Icon(Icons.delete_outline)),
            title: Card(
              color: theme.colorScheme.primary,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MergeSemantics(
                    child: Wrap(
                      children: [
                        Text(
                          m.first,
                          style: textStyle,
                        ),
                        Text(
                          m.second,
                          style: textStyle,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )))
        .toList();
    return SafeArea(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text('You have '
                '${appState.favorites.length} favorites:'),
          ),
          // for (var msg in appState.favorites) Text(msg.asLowerCase),
          ...favorites
        ],
      ),
    );
  }
}
