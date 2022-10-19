import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/common/basic_screen.dart';
import 'package:flutter_study/model/restaurant/provider/restaurant_provider.dart';

import 'package:flutter_study/view/restaurant/widgets/restaurant_card.dart';
import 'package:flutter_study/view/restaurant_detail/widgets/product_card.dart';

import '../../model/restaurant/restaurant_detail_model.dart';
import '../../model/restaurant/restaurant_model.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final RestaurantModel item;
  final String id;
  const RestaurantDetailScreen({super.key, required this.item, required this.id});

  @override
  ConsumerState<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends ConsumerState<RestaurantDetailScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(restaurantProvider.notifier).getDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restauratnDetailProvider(widget.id));

    if (state == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    return BasicScreen(
      title: widget.item.name,
      child: CustomScrollView(
        slivers: [
          renderTop(state),
          // if (state is! RestaurantDetailModel)
          //   const Center(
          //     child: CircularProgressIndicator(),
          //   ),
          if (state is RestaurantDetailModel) renderLabel(),
          if (state is RestaurantDetailModel) renderProduct(state.products),
        ],
      ),
    );
  }

  Widget renderTop(RestaurantModel model) {
    // sliver 안에 일반 위젯을 넣을시 필dy
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RestaurantCard(
            item: model,
            isDetail: true,
          ),
          if (model is RestaurantDetailModel)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(model.detail),
            )
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
