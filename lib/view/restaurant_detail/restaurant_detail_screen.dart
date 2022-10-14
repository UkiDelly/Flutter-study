import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/common/basic_screen.dart';

import 'package:flutter_study/repository/restaurant_repo.dart';
import 'package:flutter_study/view/restaurant/widgets/restaurant_card.dart';
import 'package:flutter_study/view/restaurant_detail/widgets/product_card.dart';

import '../../model/restaurant/restaurant_detail_model.dart';
import '../../model/restaurant/restaurant_model.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final RestaurantModel item;
  final String? detail;
  const RestaurantDetailScreen({super.key, required this.item, this.detail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(restaurantRepositoryProvider);
    return BasicScreen(
      title: item.name,
      child: FutureBuilder<RestaurantDetailModel>(
        future: repo.getRestaurantDetail(item.id), //getRestaurantDetail(repo),
        builder: (context, AsyncSnapshot<RestaurantDetailModel> snapshot) {
          if (snapshot.hasData) {
            final item = snapshot.data!;
            return CustomScrollView(
              slivers: [
                renderTop(item),
                renderLabel(),
                renderProduct(item.products),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }

  Widget renderTop(RestaurantDetailModel model) {
    // sliver 안에 일반 위젯을 넣을시 필dy
    return SliverToBoxAdapter(
      child: Column(
        children: [
          RestaurantCard(
            item: model,
            isDetail: true,
          ),
          if (detail != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Text(
                model.detail,
              ),
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
