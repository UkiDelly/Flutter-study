import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';

import '../../common/basic_screen.dart';
import '../../common/model/cursor_pagination_model.dart';
import '../../common/utils/pagination_utils.dart';
import '../../model/restaurant/provider/restaurant_provider.dart';
import '../../model/restaurant/provider/restaurant_rating_provider.dart';
import '../../model/restaurant/rating_model.dart';
import '../../model/restaurant/restaurant_detail_model.dart';
import '../../model/restaurant/restaurant_model.dart';
import '../restaurant/widgets/restaurant_card.dart';
import 'widgets/product_card.dart';
import 'widgets/rating_card.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final RestaurantModel item;
  final String id;

  const RestaurantDetailScreen({super.key, required this.item, required this.id});

  @override
  ConsumerState<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends ConsumerState<RestaurantDetailScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(restaurantProvider.notifier).getDetail(widget.id);
    scrollController.addListener(listener);
  }

  void listener() {
    PaginationUtils.paginate(
        controller: scrollController,
        provider: ref.read(restaurantRatingProvider(widget.id).notifier));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restauratnDetailProvider(widget.id));
    final ratingState = ref.watch(restaurantRatingProvider(widget.id));

    if (state == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    return BasicScreen(
      title: widget.item.name,
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          renderTop(state),
          // if (state is! RestaurantDetailModel)
          //   const Center(
          //     child: CircularProgressIndicator(),
          //   ),
          if (state is! RestaurantDetailModel) renderLoading(),
          if (state is RestaurantDetailModel) renderLabel(),
          if (state is RestaurantDetailModel) renderProduct(state.products),
          if (ratingState is CursorPagination<RatingModel>) renderRatings(models: ratingState.data)
        ],
      ),
    );
  }

  Widget renderLoading() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SkeletonParagraph(
                style: const SkeletonParagraphStyle(padding: EdgeInsets.zero, lines: 5),
              ),
            ),
          ),
        ),
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
            heroKey: model.id,
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
            child: ProductCard.fromRestaurantModel(
              product: products[index],
            ),
          ),
          childCount: products.length,
        ),
      ),
    );
  }

  Widget renderRatings({required List<RatingModel> models}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: models.length,
          (context, index) => RatingCard.fromModel(model: models[index]),
        ),
      ),
    );
  }
}
