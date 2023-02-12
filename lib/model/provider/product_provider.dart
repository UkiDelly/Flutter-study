import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/common/model/cursor_pagination_model.dart';

import '../../common/provider/pagination_provider.dart';
import '../product/product_model.dart';
import '../repository/product_repository.dart';

final productStateNotifierProvider =
    StateNotifierProvider<ProductStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(productRepoProvider);
  return ProductStateNotifier(repository: repository);
});

class ProductStateNotifier extends PaginationNotifier<ProductRepo, ProductModel> {
  ProductStateNotifier({required super.repository});
}
