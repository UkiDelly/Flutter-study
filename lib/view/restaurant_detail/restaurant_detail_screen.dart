import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_study/api/api_list.dart';
import 'package:flutter_study/common/basic_screen.dart';
import 'package:flutter_study/common/data.dart';
import 'package:flutter_study/common/dio.dart';
import 'package:flutter_study/model/restaurant_detail_model.dart';
import 'package:flutter_study/model/restaurant_model.dart';
import 'package:flutter_study/repository/restaurant_repo.dart';
import 'package:flutter_study/view/restaurant/widgets/restaurant_card.dart';
import 'package:flutter_study/view/restaurant_detail/widgets/product_card.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final RestaurantModel item;
  final String? detail;
  const RestaurantDetailScreen({super.key, required this.item, this.detail});

  Future<RestaurantDetailModel> getRestaurantDetail() async {
    const storage = FlutterSecureStorage();

    final dio = Dio();
    dio.interceptors.add(CustomInterceptor(storage: storage));

    // repo 인스턴스 생성
    final repo = RestaurantRepo(dio, baseUrl: '$api/restaurant/');

    // detail 가져오는 함수 실행 (serialization까지 자동)
    return repo.getRestaurantDetail(item.id);
  }

  @override
  Widget build(BuildContext context) {
    return BasicScreen(
      title: item.name,
      child: FutureBuilder<RestaurantDetailModel>(
        future: getRestaurantDetail(),
        builder: (context, AsyncSnapshot<RestaurantDetailModel> snapshot) {
          if (snapshot.hasData) {
            final item = snapshot.data!;
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
