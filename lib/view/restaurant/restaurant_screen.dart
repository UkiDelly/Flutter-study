import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/api/api_list.dart';
import 'package:flutter_study/common/data.dart';
import 'package:flutter_study/view/restaurant/widgets/restaurant_card.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> pageinateRestaurant() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final response =
        await Dio().get('$apiUrl/restaurant', options: Options(headers: {'authorization': 'Bearer $accessToken'}));

    return response.data['data'];
  }

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
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return RestaurantCard(
                    image: Image.network(
                      '$apiUrl/${item['thumbUrl']}',
                      fit: BoxFit.cover,
                    ),
                    name: item['name'],
                    tags: List<String>.from(item['tags']),
                    ratingsCount: item['ratingsCount'],
                    deliveryTime: item['deliveryTime'],
                    deliveryFee: item['deliveryFee'],
                    ratings: item['ratings'],
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
