import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/common/model/cursor_pagination_model.dart';
import 'package:flutter_study/common/utils/pagination_utils.dart';
import 'package:flutter_study/model/restaurant/provider/restaurant_provider.dart';
import 'package:flutter_study/model/restaurant/restaurant_model.dart';
import 'package:flutter_study/view/restaurant/widgets/restaurant_card.dart';
import 'package:flutter_study/view/restaurant_detail/restaurant_detail_screen.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // 특정 값이 바뀔때마다 함수가 실행
    _scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    // 현재 위치가
    // 최대 길이보다 조금 덜 되는 위치까지 왔을때,
    // 새로운 데이터 추가요청

    // 현재 위치 가져오기
    // conrtroller의 오프셋이 ListView 최대 길이보다 300px 덜 되는 위치에 왔으면
    // if (_scrollController.offset > _scrollController.position.maxScrollExtent - 300) {
    //   // 데이터 추가 요청
    //   ref.read(restaurantProvider.notifier).paginate(fetchMore: true);
    // }

    // 일반화해서 사용
    PaginationUtils.paginate(
        controller: _scrollController, provider: ref.read(restaurantProvider.notifier));
  }

  @override
  Widget build(BuildContext context) {
    //
    final data = ref.watch(restaurantProvider);

    // 완전 처음 로딩중일때
    if (data is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );

      // 에러가 발생할때
    } else if (data is CursorPaginationError) {
      return Center(
        child: Text(data.message),
      );
    }

    // 나머지 3개의 상태
    // CursorPagination
    // CursorPaginationFetchingMore
    // CursorPaginationRefetching
    // 는 CursorPagination을 상속하고 있으므로 CursorPagintaion과 같다.
    // 데이터가 성공적으로 들어올때
    final cp = data as CursorPagination;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        controller: _scrollController,
        itemCount: cp.data.length + 1,
        itemBuilder: (context, index) {
          if (index == cp.data.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Center(
                child: data is CursoPaginationFetchingMore
                    ? const CircularProgressIndicator()
                    : const Text(
                        '마지막 데이터입니다',
                      ),
              ),
            );
          }
          // final item = snapshot.data![index];,
          final pItem = cp.data[index] as RestaurantModel;

          return InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => RestaurantDetailScreen(
                  item: pItem,
                  id: pItem.id,
                ),
              ),
            ),
            child: RestaurantCard(
              item: pItem,
              heroKey: pItem.id,
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
