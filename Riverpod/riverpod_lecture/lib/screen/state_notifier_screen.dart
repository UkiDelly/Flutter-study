import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lecture/common/widgets/default_layout.dart';
import 'package:riverpod_lecture/model/shopping_item_model.dart';
import 'package:riverpod_lecture/riverpod/state_notifier.dart';

class StateNotifierProviderScreen extends ConsumerWidget {
  const StateNotifierProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // UI에서 보여줘야 하기 때문에 watch
    final List<ShoppingItemModel> state = ref.watch(shoppingListNotifierProvider);

    return DefaultLayout(
      title: 'State Notifier Provider',
      body: Center(
        child: ListView(
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
      ),
    );
  }
}
