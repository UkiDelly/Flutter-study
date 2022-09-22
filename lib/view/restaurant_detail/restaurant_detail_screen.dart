import 'package:flutter/material.dart';
import 'package:flutter_study/common/basic_screen.dart';
import 'package:flutter_study/model/restaurant_model.dart';
import 'package:flutter_study/view/restaurant/widgets/restaurant_card.dart';
import 'package:flutter_study/view/restaurant_detail/widgets/product_card.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final RestaurantModel item;
  final String? detail;
  const RestaurantDetailScreen({super.key, required this.item, this.detail});

  @override
  Widget build(BuildContext context) {
    return BasicScreen(
      title: item.name,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RestaurantCard(
            item: item,
            isDetail: true,
          ),
          if (detail != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Text(
                detail!,
              ),
            ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ProductCard(),
          )
        ],
      ),
    );
  }
}
