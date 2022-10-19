import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/common/basic_screen.dart';
import 'package:flutter_study/model/restaurant/provider/restaurant_provider.dart';

import 'package:flutter_study/view/restaurant/widgets/restaurant_card.dart';
import 'package:flutter_study/view/restaurant_detail/widgets/product_card.dart';

import '../../model/restaurant/restaurant_detail_model.dart';
import '../../model/restaurant/restaurant_model.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final RestaurantModel item;
  final String id;
  const RestaurantDetailScreen({super.key, required this.item, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(restauratnDetailProvider(id));

    if (state == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    return BasicScreen(
      title: item.name,
      child: CustomScrollView(
        slivers: [
          renderTop(state),
          // renderLabel(),
          // renderProduct(item.products),
        ],
      ),
    );
  }

  Widget renderTop(RestaurantModel model) {
    // sliver 안에 일반 위젯을 넣을시 필dy
    return SliverToBoxAdapter(
      child: Column(
        children: [
          RestaurantCard(
            item: model,
            isDetail: true,
          ),
        ],
      ),
    );
  }

  Widget renderLabel() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget renderProduct(List<RestaurantProductModel> products) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ProductCard(
              products[index],
            ),
          ),
          childCount: products.length,
        ),
      ),
    );
  }
}
