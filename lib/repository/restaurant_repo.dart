import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/common/dio.dart';
import 'package:flutter_study/common/model/cursor_pagination_model.dart';
import 'package:flutter_study/common/model/pagination_params.dart';

import 'package:retrofit/http.dart';

import '../api/api_list.dart';
import '../model/restaurant/restaurant_detail_model.dart';
import '../model/restaurant/restaurant_model.dart';

part 'restaurant_repo.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepo>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = RestaurantRepo(dio, baseUrl: '$api/restaurant');
  return repository;
});

// restAPI 사용
@RestApi()
abstract class RestaurantRepo {
  // baseUrl: http://localhost:3000/restaurant
  factory RestaurantRepo(Dio dio, {String baseUrl}) = _RestaurantRepo;

  // http://localhost:3000/restaurant/
  @GET('/')
  @Headers(
    {'accessToken': 'true'},
  )
  Future<CursorPagination<RestaurantModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  // get 메소드 그리고 path
  @GET('/{id}')
  @Headers(
    {'accessToken': 'true'},
  )
  // JsonSerialization이 된 Model로 자동으로 반환
  Future<RestaurantDetailModel> getRestaurantDetail(
    // {id}와 자동으로 매칭된다
    @Path() String id,
  );
}
