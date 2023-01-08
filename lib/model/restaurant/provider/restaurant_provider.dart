import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/common/model/cursor_pagination_model.dart';
import 'package:flutter_study/common/provider/pagination_provider.dart';
import 'package:flutter_study/repository/restaurant_repo.dart';

import '../restaurant_model.dart';

final restauratnDetailProvider = Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);

  // restaurantStateNotifire의 state이 CursorPagaintion이 아니라면, (즉, 데이터가 없다면)
  if (state is! CursorPagination<RestaurantModel>) {
    // null 반환
    return null;
  }

  // 데이터가 있을때, restaurantStateNotifire의 state의 리스트에 있는 RestaurantModel의 id가 Provider이 id 값과 동일하다면 반환
  return state.data.firstWhere((item) => item.id == id);
});

final restaurantProvider = StateNotifierProvider<RestaurantNotifier, CursorPaginationBase>((ref) {
  // provider에 있는 repo 가져오기
  final repository = ref.watch(restaurantRepositoryProvider);

  // stateNotifier 생성
  return RestaurantNotifier(repository: repository);
});

// CursorPagination을 제너릭으로 넣으면 CursoPagination의 상태만 관리할수 있으므로,
// CursoPaginationBase으로 제너릭을 변경하여 모든 상태를 관리 할수 있게 바꾼다.
class RestaurantNotifier extends PaginationNotifier<RestaurantRepo, RestaurantModel> {
  // super(){} 안에 함수를 넣으면, class가 생성될때 바로 실행할수 있게 할수 있다.
  // StateNotifier가 생성되자마자 paginate() 함수를 실행하므로, CursorPagination의 상태를 Loading으로 init한다.
  RestaurantNotifier({required super.repository});

  void getDetail(String id) async {
    // 아직 데이터가 하나도 없는 상태라면 즉, CursorPagination이 아니라면
    // 데이터를 가져오는 시도를 한다.
    if (state is! CursorPagination) {
      await paginate();
    }

    // state가 CursorPagination이 아닐때 그냥 리턴
    if (state is! CursorPagination) return;

    // 데이터가 있는 상황
    final tempState = state as CursorPagination<RestaurantModel>;

    // detail api를 호출하여
    final res = await repository.getRestaurantDetail(id);

    state = tempState.copyWith(
      data: tempState.data
          .map<RestaurantModel>(
            // state 리스트의 RestaurantModel 데이터의 id가 입려받은 id 값과 일치하면, api 요청으로 받은 RestaurantDetailModel으로 변경하고
            // id 값이 같지 않다면 그냥 원래 데이터를 반환

            // 즉 [RestaurantModel(1),RestaurantModel(2),RestaurantModel(3)] 에서 RestaurantModel(2)의 detail을 가져온다면 state는  [RestaurantModel(1),RestaurantDeatilModel(2),RestaurantModel(3)]로 변경된다.
            // 변경이 가능한 이유는 RestaurantDetailModel은 RestauranModel은 상속 받기 때문이다.
            (e) => e.id == id ? res : e,
          )
          .toList(),
    );
  }
}
