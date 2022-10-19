// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

// base 상태
// 모든 상태들을 이 class를 상속하여 관리하기 용이하도록 만든것이다.
abstract class CursorPaginationBase {}

// error 상태
class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError(this.message);
}

// loading 상태
class CursorPaginationLoading extends CursorPaginationBase {}

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

  CursorPagination<T> copyWith({
    CursorPaginationMeta? meta,
    List<T>? data,
  }) {
    return CursorPagination<T>(
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }
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
class CursorPaginationRefetching<T> extends CursorPagination<T> {
  CursorPaginationRefetching({required super.meta, required super.data});
}

// 리스트의 맨 아래로 내려서
// 추가 데이터를 요청하는 중일때
// CursorPaginationLoding을 쓰지 않는 이유은 meta 데이터가 없기 때문에 데이터가 증발한다.
class CursoPaginationFetchingMore<T> extends CursorPagination<T> {
  CursoPaginationFetchingMore({required super.meta, required super.data});
}
