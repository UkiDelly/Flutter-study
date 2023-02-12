import 'package:flutter/material.dart';
import 'package:flutter_study/common/pagination_listview.dart';
import 'package:flutter_study/model/product/product_model.dart';
import 'package:flutter_study/model/provider/product_provider.dart';
import 'package:flutter_study/view/restaurant_detail/widgets/product_card.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productStateNotifierProvider,
      itemBuilder: <ProductModel>(context, index, model) {
        return ProductCard.fromProductModel(model: model);
      },
    );
  }
}
