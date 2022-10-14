import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/model/restaurant/restaurant_model.dart';
import 'package:flutter_study/repository/restaurant_repo.dart';



final restaurantProvider = StateNotifierProvider<RestaurantNotifier, List<RestaurantModel>>((ref) {

  // provider에 있는 repo 가져오기
  final repository = ref.watch(restaurantRepositoryProvider);

  // stateNotifier 생성
  return RestaurantNotifier(repository: repository);
});

class RestaurantNotifier extends StateNotifier<List<RestaurantModel>> {
  final RestaurantRepo repository;

  // super(){} 안에 함수를 넣으면, class가 생성될때 바로 실행할수 있게 할수 있다.
  RestaurantNotifier({required this.repository}) : super([]) {
    // 이 안에 함수를 넣으면 class Instance가 생성되는 즉시 실행된다.
    paginate();
  }

  // 데이터 가져오기
  paginate() async {
    final res = await repository.paginate();
    state = res.data;
  }
}
