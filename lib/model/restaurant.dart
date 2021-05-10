import 'dart:convert';

import 'package:dicoding_flutter_fundamental/model/restaurants.dart';

class Restaurant {
  List<Restaurants> restaurants;

  Restaurant({this.restaurants});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    var restoList = [];
    if (json['restaurants'] != null) {
      restoList = new List<Restaurants>();
      json['restaurants'].forEach((v) {
        restoList.add(new Restaurants.fromJson(v));
      });
    }
    return Restaurant(restaurants: restoList);
  }
}

Restaurant parseLocal(var response) {
  dynamic jsonObject = json.decode(response);
  return Restaurant.fromJson(jsonObject);
}
