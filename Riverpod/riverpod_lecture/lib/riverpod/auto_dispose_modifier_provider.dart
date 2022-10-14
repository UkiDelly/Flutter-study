import 'package:flutter_riverpod/flutter_riverpod.dart';


// auto dispose는 자동으로 삭제한다.
// 즉 필요 없으면 자동으로 삭제하고, 필요하면 다시 불러온다.
final autoDisposeModifierProvider = FutureProvider.autoDispose<List<int>>((ref) async {
  await Future.delayed(const Duration(seconds: 2));
  return [1, 2, 3, 4, 5];
});
