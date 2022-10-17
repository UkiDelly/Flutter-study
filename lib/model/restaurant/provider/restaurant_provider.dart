import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/common/model/cursor_pagination_model.dart';
import 'package:flutter_study/repository/restaurant_repo.dart';

final restaurantProvider = StateNotifierProvider<RestaurantNotifier, CursorPaginationBase>((ref) {
  // provider에 있는 repo 가져오기
  final repository = ref.watch(restaurantRepositoryProvider);

  // stateNotifier 생성
  return RestaurantNotifier(repository: repository);
});

// CursorPagination을 제너릭으로 넣으면 CursoPagination의 상태만 관리할수 있으므로,
// CursoPaginationBase으로 제너릭을 변경하여 모든 상태를 관리 할수 있게 바꾼다.
class RestaurantNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepo repository;

  // super(){} 안에 함수를 넣으면, class가 생성될때 바로 실행할수 있게 할수 있다.
  // StateNotifier가 생성되자마자 paginate() 함수를 실행하므로, CursorPagination의 상태를 Loading으로 init한다.
  RestaurantNotifier({required this.repository}) : super(CursorPaginationLoading()) {
    // 이 안에 함수를 넣으면 class Instance가 생성되는 즉시 실행된다.
    paginate();
  }

  // 데이터 가져오기
  paginate() async {
    final res = await repository.paginate();
    state = res;
  }
}
