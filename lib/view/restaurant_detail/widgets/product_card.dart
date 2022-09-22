import 'package:flutter/material.dart';
import 'package:flutter_study/common/colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    // 최대 크기를 가진 위젯만큼 공간을 가지게 된다.
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'asset/img/food/ddeok_bok_gi.jpg',
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
              children: const [
                Text(
                  "떡볶이",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "전통 떡볶이의 정석!\n맛있습니다.",
                  maxLines: 2,
                  // 텍스트가 maxLine보다 길 경우 ...으로 표기
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: bodyTextColor, fontSize: 14),
                ),
                Text(
                  "₩10000",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: primaryColor, fontSize: 12, fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
