import 'package:flutter_study/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_detail_model.g.dart';

@JsonSerializable()
class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.priceRange,
    required super.tags,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) => _$RestaurantDetailModelFromJson(json);

  // factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) => RestaurantDetailModel(
  //       id: json['id'],
  //       name: json['name'],
  //       thumbUrl: json['thumbUrl'],
  //       priceRange: RestaurantPriceRange.values.firstWhere((element) => element.name == json['priceRange']),
  //       tags: List<String>.from(json['tags']),
  //       ratings: json['ratings'],
  //       ratingsCount: json['ratingsCount'],
  //       deliveryTime: json['deliveryTime'],
  //       deliveryFee: json['deliveryFee'],
  //       detail: json['detail'],
  //       products: json['products']
  //           .map<RestaurantProductModel>((product) => RestaurantProductModel.fromJson(product))
  //           .toList(),
  //     );
}

@JsonSerializable()
class RestaurantProductModel {
  final String id, name, imgUrl, detail;
  final int price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

  factory RestaurantProductModel.fromJson(Map<String, dynamic> json) => _$RestaurantProductModelFromJson(json);

  // factory RestaurantProductModel.fromJson(Map<String, dynamic> json) => RestaurantProductModel(
  //       id: json['id'],
  //       name: json['name'],
  //       imgUrl: json['imgUrl'],
  //       detail: json['detail'],
  //       price: json['price'],
  //     );
}
