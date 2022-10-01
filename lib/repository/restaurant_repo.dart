import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_study/common/model/cursor_pagination_model.dart';
import 'package:flutter_study/model/restaurant_detail_model.dart';
import 'package:flutter_study/model/restaurant_model.dart';
import 'package:retrofit/http.dart';

part 'restaurant_repo.g.dart';

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
  Future<CursorPagination<RestaurantModel>> paginate();

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
