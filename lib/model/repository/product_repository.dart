import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/api/api_list.dart';
import 'package:flutter_study/common/dio.dart';
import 'package:flutter_study/common/repository/base_pagination_repo.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/model/cursor_pagination_model.dart';
import '../../common/model/pagination_params.dart';
import '../product/product_model.dart';

part 'product_repository.g.dart';

final productRepoProvider = Provider<ProductRepo>((ref) {
  final dio = ref.watch(dioProvider);
  final String baseUrl = '$api/product';
  return ProductRepo(dio, baseUrl: baseUrl);
});

// http:$api/product
@RestApi()
abstract class ProductRepo implements IBasePaginationRepo<ProductModel> {
  factory ProductRepo(Dio dio, {String? baseUrl}) = _ProductRepo;

  @override
  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<ProductModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
