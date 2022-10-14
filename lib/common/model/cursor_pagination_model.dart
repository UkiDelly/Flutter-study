import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

// base 상태
abstract class CursorPaginationBase {}

// error 상태
abstract class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError(this.message);
}

// loading 상태
abstract class CursorPaginationLoading extends CursorPaginationBase {}

// 모든 응답의 모양이 같지만 data값만 다름, 그래서 data 타입만 원하는 타입으로 쓸수 있게 generic타입 T를 추가
@JsonSerializable(
  genericArgumentFactories: true,
)
class CursorPagination<T> extends CursorPaginationBase {
  final CursorPaginationMeta meta;
  final List<T> data;

  CursorPagination({
    required this.meta,
    required this.data,
  });

  factory CursorPagination.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore,
  });

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) => _$CursorPaginationMetaFromJson(json);
}

// 새로고침 할때
class CursorPaginationRefetching extends CursorPagination {
  CursorPaginationRefetching({required super.meta, required super.data});
}

// 리스트의 맨 아래로 내려서
// 추가 데이터를 요청하는 중일때
class CursoPaginationFetchingMore extends CursorPagination {
  CursoPaginationFetchingMore({required super.meta, required super.data});
}
