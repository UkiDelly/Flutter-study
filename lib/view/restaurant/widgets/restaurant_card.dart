import 'package:flutter/material.dart';
import 'package:flutter_study/api/api_list.dart';
import 'package:flutter_study/common/colors.dart';

import '../../../model/restaurant/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantModel item;
  final bool isDetail;

  const RestaurantCard({
    super.key,
    required this.item,
    this.isDetail = false,
  });

  renderDot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        ' · ',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: isDetail ? BorderRadius.zero : BorderRadius.circular(12),
            child: Image.network(
              '$api/${item.thumbUrl}',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isDetail ? 16 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  item.tags.join(' · '),
                  style: const TextStyle(color: bodyTextColor, fontSize: 14),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    _IconText(
                      icon: Icons.star,
                      label: item.ratings.toString(),
                    ),
                    renderDot(),
                    _IconText(
                      icon: Icons.receipt,
                      label: item.ratingsCount.toString(),
                    ),
                    renderDot(),
                    _IconText(
                      icon: Icons.timelapse_outlined,
                      label: '${item.deliveryTime} 분',
                    ),
                    renderDot(),
                    _IconText(
                      icon: Icons.monetization_on,
                      label: item.deliveryFee == 0 ? '무료' : item.deliveryFee.toString(),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;
  const _IconText({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 14,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
