import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lecture/model/shopping_item_model.dart';

final shoppingListNotifierProvider =
    StateNotifierProvider<ShoppingListNotifier, List<ShoppingItemModel>>((ref) => ShoppingListNotifier());

class ShoppingListNotifier extends StateNotifier<List<ShoppingItemModel>> {
  ShoppingListNotifier()

      // super 안에는 초기화할 값을 넣는다.
      : super([
          ShoppingItemModel(name: '김치', quantity: 3, hasBought: false, isSpicy: true),
          ShoppingItemModel(name: '라면', quantity: 5, hasBought: false, isSpicy: true),
          ShoppingItemModel(name: '삼겹살', quantity: 10, hasBought: false, isSpicy: false),
          ShoppingItemModel(name: '수박', quantity: 2, hasBought: false, isSpicy: true),
          ShoppingItemModel(name: '카스테라', quantity: 3, hasBought: false, isSpicy: false),
        ]);


  // state 새로운 값을 할당할수 있지만, state안의 값은 수정이 불가능하다.
  void toggleHasBought(String name) {
    state = state.map((item) {
      if (item.name == name) {
        final updatedItem = item.copyWith(hasBought: !item.hasBought);
        return updatedItem;
      } else {
        return item;
      }
    }).toList();
  }
}
