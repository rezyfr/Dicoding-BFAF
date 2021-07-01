import 'package:dicoding_flutter_fundamental/data/model/restaurant_detail.dart';

class RestaurantDetailResult {
  RestaurantDetailResult({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  bool error;
  String message;
  RestaurantDetail restaurant;

  factory RestaurantDetailResult.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailResult(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantDetail.fromJson(json["restaurant"]),
      );
}
