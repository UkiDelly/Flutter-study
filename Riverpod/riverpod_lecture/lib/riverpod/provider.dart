import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lecture/model/shopping_item_model.dart';
import 'package:riverpod_lecture/riverpod/state_notifier.dart';

final filteredShoppingListProvider = Provider<List<ShoppingItemModel>>((ref) {
  // shopping List State Notifier Provider를 읽어온다.
  final shoppingListState = ref.watch(shoppingListNotifierProvider);

  // filter Provider를 읽어온다.
  final filter = ref.watch(filterProvider);

  if (filter == FilterState.all) {
    return shoppingListState;
  }
  return shoppingListState
      .where((element) => filter == FilterState.spicy ? element.isSpicy : !element.isSpicy)
      .toList();
});

enum FilterState { notSpicy, spicy, all }

final filterProvider = StateProvider<FilterState>((ref) => FilterState.all);
