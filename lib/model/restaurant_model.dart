enum RestaurantPriceRange { expensive, medium, cheap }

class RestaurantModel {
  final String id, name, thumbUrl;
  final RestaurantPriceRange priceRange;
  final List<String> tags;
  final int ratingsCount, deliveryTime, deliveryFee;
  final double ratings;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.priceRange,
    required this.tags,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) => RestaurantModel(
        id: json['id'],
        name: json['name'],
        thumbUrl: json['thumbUrl'],
        priceRange: RestaurantPriceRange.values.firstWhere((element) => element.name == json['priceRange']),
        tags: List<String>.from(json['tags']),
        ratings: json['ratings'],
        ratingsCount: json['ratingsCount'],
        deliveryTime: json['deliveryTime'],
        deliveryFee: json['deliveryFee'],
      );
}
