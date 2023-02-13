import 'package:flutter/material.dart';
import 'package:flutter_study/common/pagination_listview.dart';
import 'package:flutter_study/model/product/product_model.dart';
import 'package:flutter_study/view/restaurant_detail/restaurant_detail_screen.dart';
import 'package:flutter_study/view/restaurant_detail/widgets/product_card.dart';

import '../../model/provider/product_provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productStateNotifierProvider,
      itemBuilder: <ProductModel>(context, index, model) {
        return InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => RestaurantDetailScreen(
                id: model.restaurant.id,
              ),
            ),
          ),
          child: ProductCard.fromProductModel(model: model),
        );
      },
    );
  }
}
