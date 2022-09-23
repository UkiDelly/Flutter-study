import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/api/api_list.dart';
import 'package:flutter_study/common/basic_screen.dart';
import 'package:flutter_study/common/data.dart';
import 'package:flutter_study/model/restaurant_detail_model.dart';
import 'package:flutter_study/model/restaurant_model.dart';
import 'package:flutter_study/view/restaurant/widgets/restaurant_card.dart';
import 'package:flutter_study/view/restaurant_detail/widgets/product_card.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final RestaurantModel item;
  final String? detail;
  const RestaurantDetailScreen({super.key, required this.item, this.detail});

  Future<Map<String, dynamic>> getRestaurantDetail() async {
    final url = '$api/restaurant/${item.id}';

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    Response response = await Dio().get(
      url,
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );

    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return BasicScreen(
      title: item.name,
      child: FutureBuilder<Map<String, dynamic>>(
        future: getRestaurantDetail(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            final item = RestaurantDetailModel.fromJson(snapshot.data!);
            return CustomScrollView(
              slivers: [renderTop(item), renderLabel(), renderProduct(item.products)],
            );
          }

          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }

  Widget renderTop(RestaurantDetailModel model) {
    // sliver 안에 일반 위젯을 넣을시 필요
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
