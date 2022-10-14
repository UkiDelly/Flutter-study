import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/api/api_list.dart';
import 'package:flutter_study/common/dio.dart';
import 'package:flutter_study/model/restaurant_model.dart';
import 'package:flutter_study/repository/restaurant_repo.dart';
import 'package:flutter_study/view/restaurant/widgets/restaurant_card.dart';
import 'package:flutter_study/view/restaurant_detail/restaurant_detail_screen.dart';

class RestaurantScreen extends ConsumerWidget {
  RestaurantScreen({super.key});

  Future<List<RestaurantModel>> pageinateRestaurant(Dio dio) async {


    final response = await RestaurantRepo(dio, baseUrl: '$api/restaurant').paginate();

    return response.data;
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder<List<RestaurantModel>>(
            future: pageinateRestaurant(ref.read(dioProvider)),
            builder: (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              return ListView.separated(
                controller: _scrollController,
                itemBuilder: (context, index) {
                  // final item = snapshot.data![index];,
                  final pItem = snapshot.data![index];

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
                itemCount: snapshot.data!.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
