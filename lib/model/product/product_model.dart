import 'package:flutter_study/common/model/model_with_id.dart';
import 'package:flutter_study/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

import '../restaurant/restaurant_model.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel implements IModelWithId {
  @override
  final String id;

  // 이름, 상세, 이미지
  final String name, detail;
  @JsonKey(fromJson: DataUtils.pathToUrl)
  final String imgUrl;

  //  상품 가격
  final int price;

  //  상품이 속한 식당
  final RestaurantModel restaurant;

  ProductModel(
      {required this.id,
      required this.name,
      required this.detail,
      required this.imgUrl,
      required this.price,
      required this.restaurant});

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
}
