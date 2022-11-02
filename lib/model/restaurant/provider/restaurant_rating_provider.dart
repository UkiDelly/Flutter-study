import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/common/model/cursor_pagination_model.dart';
import 'package:flutter_study/common/model/pagination_params.dart';
import 'package:flutter_study/repository/restaurant_rating_repo.dart';

class RestaurantRatingStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRatingRepo repository;
  RestaurantRatingStateNotifier({required this.repository}) : super(CursorPaginationLoading());

}
