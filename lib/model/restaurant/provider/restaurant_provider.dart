import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/common/model/cursor_pagination_model.dart';
import 'package:flutter_study/repository/restaurant_repo.dart';

import '../../../common/model/pagination_params.dart';
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
class RestaurantNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepo repository;

  // super(){} 안에 함수를 넣으면, class가 생성될때 바로 실행할수 있게 할수 있다.
  // StateNotifier가 생성되자마자 paginate() 함수를 실행하므로, CursorPagination의 상태를 Loading으로 init한다.
  RestaurantNotifier({required this.repository}) : super(CursorPaginationLoading()) {
    // 이 안에 함수를 넣으면 class Instance가 생성되는 즉시 실행된다.
    paginate();
  }

  // 데이터 가져오기
  void paginate({
    int fetchCount = 20,

    // true - 데이터 추가로 가져오기
    // false - 새로고침 (현재 상태를 덮어씌움)
    bool fetchMore = false,

    // 강제로 다시 로딩하기
    // true - CursorPaginationLoading()
    bool forceRefetch = false,
  }) async {
    try {
      //* 바로 반환하는 상황
      // 1. hasMore = false (기존 상태에서 이미 다음 데이터가 없을때)
      if (state is CursorPagination && forceRefetch == false) {
        // state을 CursorPagination으로 파싱
        final tempState = state as CursorPagination;

        // 더이상 데이터가 존재하지 않을때
        if (tempState.meta.hasMore == false) {
          // 반환
          return;
        }
      }

      // 2. 로딩중 - fetchMore : true
      // 2-1. fetchMore가 false일때 - 새로고침할 의도가 있을수 있다. 이때는 반환하지 않는다.
      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursoPaginationFetchingMore;
      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) return;

      // 5 가지 가능성
      // State의 상태

      //? 1. CursorPagination - 정상적으로 데이터가 있는 상태
      //? 2. CursorPaginationLoading - 데이터가 로딩중인 상태 (현재 캐시 없음)

      //? 3. CursorPaginationError - 에러가 발생한 상태
      //? 4. CursorPaginationRefetching - 다시 첫번째부터 데이터를 가져올때

      //? 5. CursorPaginationFetchMore - 추가 데이터를 요청할때

      // PaginationParams 생성
      PaginationParams params = PaginationParams(count: fetchCount);

      // fetchMore
      // 데이터를 더 가져오는 상황
      if (fetchMore) {
        // fetchMore가 true인 상황은 state가 CursoPagintaion 즉, 데이터를 가지고 있는 상황이므로, state가 데이터를 가지고 있다고 확실시 한다.
        final tempState = state as CursorPagination;

        // 상태를 fetchingMore으로 변경
        state = CursoPaginationFetchingMore(meta: tempState.meta, data: tempState.data);

        // param에 마지막 item의 id 추가
        params = params.copyWith(after: tempState.data.last.id);

        // 데이터를 처음부터 가져오는 상황
      } else {
        // 만약 데이터가 있는 상황이면
        // 기존 데이터를 보존한채로 fetch (api 요청)을 진행
        if (state is CursorPagination && !forceRefetch) {
          final tempState = state as CursorPagination;
          state = CursorPaginationRefetching(meta: tempState.meta, data: tempState.data);

          // 나머지 상황
        } else {
          state = CursorPaginationLoading();
        }
      }

      final res = await repository.paginate(paginationParams: params);

      // 데이터를 더 가져오는 상황
      if (state is CursoPaginationFetchingMore) {
        final tempState = state as CursoPaginationFetchingMore;

        // 기존 데이터에
        // 새로운 데이터를 추가
        state = res.copyWith(
          data: [...tempState.data, ...res.data],
        );

        // 데이터를 더 가져오는 상황이 아니라면
      } else {
        state = res;
      }
    } catch (e) {
      state = CursorPaginationError('데이터를 가져오지 못했습니다.');
    }
  }
}
