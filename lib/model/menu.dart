import 'package:dicoding_flutter_fundamental/model/food.dart';
import 'drink.dart';

class Menus {
  List<Foods> foods;
  List<Drinks> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    List<Foods> foodList = [];
    List<Drinks> drinkList = [];
    if (json['foods'] != null) {
      json['foods'].forEach((v) {
        foodList.add(new Foods.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      json['drinks'].forEach((v) {
        drinkList.add(new Drinks.fromJson(v));
      });
    }
    return Menus(
      foods: foodList,
      drinks: drinkList
    );
  }
}