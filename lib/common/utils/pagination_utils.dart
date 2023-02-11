import 'package:flutter/cupertino.dart';
import 'package:flutter_study/common/provider/pagination_provider.dart';

class PaginationUtils {
  static void paginate(
      {required ScrollController controller, required PaginationNotifier provider}) {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      // 데이터 추가 요청
      provider.paginate(fetchMore: true);
    }
  }
}
