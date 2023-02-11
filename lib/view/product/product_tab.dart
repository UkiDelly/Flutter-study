import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/common/model/cursor_pagination_model.dart';
import 'package:flutter_study/model/product/product_model.dart';

import '../../model/provider/product_provider.dart';

class ProductTabView extends ConsumerStatefulWidget {
  const ProductTabView({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _ProductTabViewState();
}

class _ProductTabViewState extends ConsumerState<ProductTabView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productStateNotifierProvider);

    if (state is CursorPagination<ProductModel>) return Placeholder();
    return Container();
  }
}
