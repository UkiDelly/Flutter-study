import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/api/api_list.dart';
import 'package:flutter_study/common/basic_screen.dart';
import 'package:flutter_study/common/data.dart';
import 'package:flutter_study/model/restaurant_model.dart';
import 'package:flutter_study/view/restaurant/widgets/restaurant_card.dart';
import 'package:flutter_study/view/restaurant_detail/widgets/product_card.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final RestaurantModel item;
  final String? detail;
  const RestaurantDetailScreen({super.key, required this.item, this.detail});

  Future getRestaurantDetail() async {
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

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return BasicScreen(
      title: item.name,
      child: FutureBuilder(
        future: getRestaurantDetail(),
        builder: (context, snapshot) {
          print(snapshot.data);
          return CustomScrollView(
            slivers: [renderTop(), renderLabel(), renderProduct()],
          );
        },
      ),
    );
  }

  Widget renderTop() {
    return // sliver 안에 일반 위젯을 넣을시 필요
        SliverToBoxAdapter(
      child: Column(
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

  Widget renderProduct() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: ProductCard(),
          ),
          childCount: 10,
        ),
      ),
    );
  }
}