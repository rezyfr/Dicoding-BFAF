import 'package:dicoding_flutter_fundamental/model/food.dart';
import 'drink.dart';

class Menus {
  List<Foods> foods;
  List<Drinks> drinks;

  Menus({this.foods, this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    var foodList = [];
    var drinkList = [];
    if (json['foods'] != null) {
      foodList = new List<Foods>();
      json['foods'].forEach((v) {
        foodList.add(new Foods.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      drinkList = new List<Drinks>();
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