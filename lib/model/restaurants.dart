import 'package:dicoding_flutter_fundamental/model/menu.dart';

class Restaurants {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  num rating;
  Menus? menus;

  Restaurants(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating,
        this.menus});

  factory Restaurants.fromJson(Map<String, dynamic> json) {
    return Restaurants(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        rating: json['rating'],
        menus:
            json['menus'] != null ? new Menus.fromJson(json['menus']) : null);
  }
}
