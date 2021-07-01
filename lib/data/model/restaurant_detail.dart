import 'dart:convert';

import 'category.dart';
import 'customer_review.dart';
import 'menu.dart';

class RestaurantDetail {
  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category> categories;
  Menus menus;
  double rating;
  List<CustomerReview> customerReviews;

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
        customerReviews: List<CustomerReview>.from(
          json["customerReviews"].map((x) => CustomerReview.fromJson(x)).where(
              (review) =>
                  review.review.toString().isNotEmpty &&
                  review.review.toString() != "Test"),
        ),
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "city": city,
      "address": address,
      "pictureId": pictureId,
      "categories": categories,
      "menus": menus.toJson(),
      "rating": rating,
      "customerReviews": customerReviews,
    };
  }

  Map<String, dynamic> toDbJson(){
    var restaurantJson = {
      "name": name,
      "description": description,
      "city": city,
      "address": address,
      "pictureId": pictureId,
      "categories": categories,
      "menus": menus.toJson(),
      "rating": rating,
      "customerReviews": customerReviews
    };
    return {
      "id": id,
      "data": json.encode(restaurantJson)
    };
  }
}
