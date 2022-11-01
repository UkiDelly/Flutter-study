import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_study/model/restaurant/rating_model.dart';
import 'package:retrofit/http.dart';

import '../common/model/cursor_pagination_model.dart';
import '../common/model/pagination_params.dart';

part 'restaurant_reating_repo.g.dart';

// http://api/restaurant/:rid/rating
@RestApi()
abstract class RestaurantRatingRepo {
  factory RestaurantRatingRepo(Dio dio, {String baseUrl}) = _RestaurantRatingRepo;

  @GET('/')
  @Headers(
    {'accessToken': 'true'},
  )
  Future<CursorPagination<RatingModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
