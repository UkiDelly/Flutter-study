import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/model/restaurant/provider/restaurant_provider.dart';

import 'package:flutter_study/view/restaurant/widgets/restaurant_card.dart';
import 'package:flutter_study/view/restaurant_detail/restaurant_detail_screen.dart';

class RestaurantScreen extends ConsumerWidget {
  RestaurantScreen({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final data = ref.watch(restaurantProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        controller: _scrollController,
        itemBuilder: (context, index) {
          // final item = snapshot.data![index];,
          final pItem = data[index];

          return InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => RestaurantDetailScreen(
                  item: pItem,
                  detail: '맜있는 떡볶이',
                ),
              ),
            ),
            child: RestaurantCard(
              item: pItem,
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: data.length,
      ),
    );
  }
}
