import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/api/api_list.dart';
import 'package:flutter_study/common/data.dart';
import 'package:flutter_study/common/dio.dart';
import 'package:flutter_study/model/restaurant_model.dart';
import 'package:flutter_study/view/restaurant/widgets/restaurant_card.dart';
import 'package:flutter_study/view/restaurant_detail/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  RestaurantScreen({super.key});

  Future<List> pageinateRestaurant() async {
    final dio = Dio();

    dio.interceptors.add(
      CustomInterceptor(storage: storage),
    );



    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final response = await Dio().get(
      '$api/restaurant',
      options: Options(
        headers: {'authorization': 'Bearer $accessToken'},
      ),
    );

    return response.data['data'];
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder<List>(
            future: pageinateRestaurant(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              return ListView.separated(
                controller: _scrollController,
                itemBuilder: (context, index) {
                  // final item = snapshot.data![index];,
                  final pItem = RestaurantModel.fromJson(snapshot.data![index]);

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
