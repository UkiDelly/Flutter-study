import 'package:flutter/material.dart';
import 'package:flutter_study/api/api_list.dart';
import 'package:flutter_study/common/colors.dart';

import '../../../model/restaurant/restaurant_detail_model.dart';

class ProductCard extends StatelessWidget {
  final RestaurantProductModel product;
  const ProductCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    // 최대 크기를 가진 위젯만큼 공간을 가지게 된다.
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              '$api/${product.imgUrl}',
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  product.detail,
                  maxLines: 2,
                  // 텍스트가 maxLine보다 길 경우 ...으로 표기
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: bodyTextColor, fontSize: 14),
                ),
                Text(
                  '₩ ${product.price}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: primaryColor, fontSize: 12, fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
