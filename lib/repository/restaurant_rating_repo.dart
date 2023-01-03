import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

import '../api/api_list.dart';
import '../common/dio.dart';
import '../common/model/cursor_pagination_model.dart';
import '../common/model/pagination_params.dart';
import '../common/repository/base_pagination_repo.dart';
import '../model/restaurant/rating_model.dart';

part 'restaurant_rating_repo.g.dart';

final restaurantRatingRepoProvider = Provider.family<RestaurantRatingRepo, String>((ref, id) {
  final dio = ref.watch(dioProvider);
  return RestaurantRatingRepo(dio, baseUrl: 'http://$api/restaurant/$id/rating');
});

// http://api/restaurant/{restaurantId}/rating
@RestApi()
abstract class RestaurantRatingRepo implements IBasePaginationRepo<RatingModel> {
  factory RestaurantRatingRepo(Dio dio, {String baseUrl}) = _RestaurantRatingRepo;

  @override
  @GET('/')
  @Headers({'accessToken': true})
  Future<CursorPagination<RatingModel>> paginate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}
