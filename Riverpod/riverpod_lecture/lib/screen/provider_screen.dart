import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lecture/common/widgets/default_layout.dart';
import 'package:riverpod_lecture/riverpod/provider.dart';

import '../riverpod/state_notifier.dart';

class ProviderScreen extends ConsumerWidget {
  const ProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(filteredShoppingListProvider);
    print('build');
    return DefaultLayout(
      title: 'Provider Screen',
      actions: [
        PopupMenuButton<FilterState>(
          itemBuilder: (context) => FilterState.values
              .map(
                (filter) => PopupMenuItem<FilterState>(
                  child: Text(filter.name),
                ),
              )
              .toList(),
          onSelected: (value) {
            ref.read(filterProvider.notifier).update((state) => value);
          },
        )
      ],
      body: ListView(
        children: List.generate(
          state.length,
          (index) => CheckboxListTile(
            title: Text(state[index].name),
            value: state[index].hasBought,
            onChanged: (value) {
              // onChanged가 실행될때 한번만 실행해야 하므로 read 사용
              ref.read(shoppingListNotifierProvider.notifier).toggleHasBought(state[index].name);
            },
          ),
        ),
      ),
    );
  }
}
