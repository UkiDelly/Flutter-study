import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/common/model/cursor_pagination_model.dart';
import 'package:flutter_study/common/provider/pagination_provider.dart';
import 'package:flutter_study/model/restaurant/rating_model.dart';
import 'package:flutter_study/repository/restaurant_rating_repo.dart';

final restaurantRatingProvider =
    StateNotifierProvider.family<RestaurantRatingStateNotifier, CursorPaginationBase, String>(
        (ref, id) {
  final repo = ref.watch(restaurantRatingRepoProvider(id));
  return RestaurantRatingStateNotifier(repository: repo);
});

class RestaurantRatingStateNotifier extends PaginationNotifier<RestaurantRatingRepo, RatingModel> {
  RestaurantRatingStateNotifier({required super.repository});
}
