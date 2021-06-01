
import 'dart:convert';

import 'package:dicoding_flutter_fundamental/data/model/restaurant_list.dart';

class RestaurantSearchResult {
  List<RestaurantList> restaurants;
  bool error;
  int founded;

  RestaurantSearchResult({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearchResult.fromJson(Map<String, dynamic> json) {
    List<RestaurantList> restoList = [];
    if (json['restaurants'] != null) {
      json['restaurants'].forEach((v) {
        restoList.add(new RestaurantList.fromJson(v));
      });
    }
    return RestaurantSearchResult(
        error: json["error"], founded: json["founded"], restaurants: restoList);
  }
}

RestaurantSearchResult parseLocal(var response) {
  dynamic jsonObject = json.decode(response);
  return RestaurantSearchResult.fromJson(jsonObject);
}
