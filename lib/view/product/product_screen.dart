import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/model/cursor_pagination_model.dart';
import '../../model/product/product_model.dart';
import '../../model/provider/product_provider.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productStateNotifierProvider);

    if (state is CursorPagination<ProductModel>) return Placeholder();
    return Container();
  }
}
