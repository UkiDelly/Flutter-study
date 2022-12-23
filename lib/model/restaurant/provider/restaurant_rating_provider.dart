import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/common/model/cursor_pagination_model.dart';
import 'package:flutter_study/repository/restaurant_rating_repo.dart';

final restaurantRatingProvider =
    StateNotifierProvider.family<RestaurantRatingStateNotifier, CursorPaginationBase, String>(
        (ref, id) {
  final repo = ref.watch(restaurantRatingRepoProvider(id));
  return RestaurantRatingStateNotifier(repo);
});

class RestaurantRatingStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRatingRepo repository;
  RestaurantRatingStateNotifier(
    this.repository,
  ) : super(CursorPaginationLoading());
}
