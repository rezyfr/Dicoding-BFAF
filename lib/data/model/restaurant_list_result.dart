import 'dart:convert';

import 'package:dicoding_flutter_fundamental/data/model/restaurant_list.dart';

class RestaurantListResult {
  List<RestaurantList> restaurants;
  bool error;
  String message;

  RestaurantListResult({
    required this.error,
    required this.message,
    required this.restaurants,
  });

  factory RestaurantListResult.fromJson(Map<String, dynamic> json) {
    List<RestaurantList> restoList = [];
    if (json['restaurants'] != null) {
      json['restaurants'].forEach((v) {
        restoList.add(new RestaurantList.fromJson(v));
      });
    }
    return RestaurantListResult(
        error: json["error"], message: json["message"], restaurants: restoList);
  }
}

RestaurantListResult parseLocal(var response) {
  dynamic jsonObject = json.decode(response);
  return RestaurantListResult.fromJson(jsonObject);
}
