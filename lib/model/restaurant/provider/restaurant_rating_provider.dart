import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/common/model/cursor_pagination_model.dart';
import 'package:flutter_study/repository/restaurant_rating_repo.dart';

class ResaturantRatingStateNotifier extends StateNotifier<CursorPaginationBase> {
  final ResaturantRatingRepo repository;
  ResaturantRatingStateNotifier(this.repository) : super(CursorPaginationLoading());
}
