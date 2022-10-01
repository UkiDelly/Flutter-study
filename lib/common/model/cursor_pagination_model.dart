import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

// 모든 응답의 모양이 같지만 data값만 다름, 그래서 data 타입만 원하는 타입으로 쓸수 있게 generic타입 T를 추가
@JsonSerializable(
  genericArgumentFactories: true,
)
abstract class CursorPagination<T> {
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
  final int hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore,
  });

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) => _$CursorPaginationMetaFromJson(json);
}
