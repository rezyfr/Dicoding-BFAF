import 'package:dicoding_flutter_fundamental/api/api_service.dart';
import 'package:dicoding_flutter_fundamental/data/model/restaurant_detail.dart';
import 'package:dicoding_flutter_fundamental/data/model/restaurant_detail_result.dart';
import 'package:dicoding_flutter_fundamental/utils/result_state.dart';
import 'package:flutter/cupertino.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  RestaurantDetailProvider({required this.apiService, required this.restaurantId}) {
    _fetchRestaurantDetail(restaurantId);
  }

  late RestaurantDetailResult _restaurant;
  late ResultState _state;
  String _message = '';

  RestaurantDetailResult get result => _restaurant;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> _fetchRestaurantDetail(id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.getRestaurantDetail(id);
      _state = ResultState.HasData;
      notifyListeners();
      return _restaurant = restaurant;
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
