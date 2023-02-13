import 'package:flutter/material.dart';
import 'package:flutter_study/model/product/product_model.dart';
import 'package:flutter_study/view/restaurant/widgets/restaurant_card.dart';
import 'package:flutter_study/view/restaurant_detail/restaurant_detail_screen.dart';

import '../../common/pagination_listview.dart';
import '../../model/restaurant/provider/restaurant_provider.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 일반화한 코드를 사용
    return PaginationListView(
      provider: restaurantProvider,
      itemBuilder: <RestaurantModel>(context, index, model) {
        return InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => RestaurantDetailScreen<ProductModel >(
                id: model.id,
              ),
            ),
          ),
          child: RestaurantCard(
            item: model,
            heroKey: model.id,
          ),
        );
      },
    );

    //
    // final data = ref.watch(restaurantProvider);
    //
    // // 완전 처음 로딩중일때
    // if (data is CursorPaginationLoading) {
    //   return const Center(
    //     child: CircularProgressIndicator(),
    //   );
    //
    //   // 에러가 발생할때
    // } else if (data is CursorPaginationError) {
    //   return Center(
    //     child: Text(data.message),
    //   );
    // }
    //
    // // 나머지 3개의 상태
    // // CursorPagination
    // // CursorPaginationFetchingMore
    // // CursorPaginationRefetching
    // // 는 CursorPagination을 상속하고 있으므로 CursorPagintaion과 같다.
    // // 데이터가 성공적으로 들어올때
    // final cp = data as CursorPagination;
    //
    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 16),
    //   child: ListView.separated(
    //     controller: _scrollController,
    //     itemCount: cp.data.length + 1,
    //     itemBuilder: (context, index) {
    //       if (index == cp.data.length) {
    //         return Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //           child: Center(
    //             child: data is CursoPaginationFetchingMore
    //                 ? const CircularProgressIndicator()
    //                 : const Text(
    //                     '마지막 데이터입니다',
    //                   ),
    //           ),
    //         );
    //       }
    //       // final item = snapshot.data![index];,
    //       final pItem = cp.data[index] as RestaurantModel;
    //
    //       return InkWell(
    //         splashFactory: NoSplash.splashFactory,
    //         onTap: () => Navigator.of(context).push(
    //           MaterialPageRoute(
    //             builder: (_) => RestaurantDetailScreen(
    //               item: pItem,
    //               id: pItem.id,
    //             ),
    //           ),
    //         ),
    //         child: RestaurantCard(
    //           item: pItem,
    //           heroKey: pItem.id,
    //         ),
    //       );
    //     },
    //     separatorBuilder: (context, index) => const Divider(),
    //   ),
    // );
  }
}
