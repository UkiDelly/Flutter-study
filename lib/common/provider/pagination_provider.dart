import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/common/model/cursor_pagination_model.dart';
import 'package:flutter_study/common/model/model_with_id.dart';
import 'package:flutter_study/common/repository/base_pagination_repo.dart';

import '../model/pagination_params.dart';

class PaginationNotifier<T extends IBasePaginationRepo<M>, M extends IModelWithId>
    extends StateNotifier<CursorPaginationBase> {
  // T는 제너릭으로, Repository 클래스를 받는다.
  final T repository;
  PaginationNotifier({required this.repository}) : super(CursorPaginationLoading()) {
    // 이 안에 함수를 넣으면 class Instance가 생성되는 즉시 실행된다.
    paginate();
  }

  // 데이터 가져오기
  Future<void> paginate({
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
        final tempState = state as CursorPagination<M>;

        // 상태를 fetchingMore으로 변경
        state = CursoPaginationFetchingMore<M>(meta: tempState.meta, data: tempState.data);

        // param에 마지막 item의 id 추가
        params = params.copyWith(after: tempState.data.last.id);

        // 데이터를 처음부터 가져오는 상황
      } else {
        // 만약 데이터가 있는 상황이면
        // 기존 데이터를 보존한채로 fetch (api 요청)을 진행
        if (state is CursorPagination && !forceRefetch) {
          final tempState = state as CursorPagination<M>;
          state = CursorPaginationRefetching<M>(meta: tempState.meta, data: tempState.data);

          // 나머지 상황
        } else {
          state = CursorPaginationLoading();
        }
      }

      final res = await repository.paginate(paginationParams: params);

      // 데이터를 더 가져오는 상황
      if (state is CursoPaginationFetchingMore) {
        final tempState = state as CursoPaginationFetchingMore<M>;

        // 기존 데이터에
        // 새로운 데이터를 추가
        state = res.copyWith(
          data: [...tempState.data, ...res.data],
        );

        // 데이터를 더 가져오는 상황이 아니라면
      } else {
        state = res;
      }
    } catch (e, stack) {
      print(e);
      print(stack);
      state = CursorPaginationError('데이터를 가져오지 못했습니다.');
    }
  }
}
