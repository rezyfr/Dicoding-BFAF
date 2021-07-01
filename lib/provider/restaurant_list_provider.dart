import 'package:dicoding_flutter_fundamental/api/api_service.dart';
import 'package:dicoding_flutter_fundamental/data/model/restaurant_list_result.dart';
import 'package:dicoding_flutter_fundamental/utils/result_state.dart';
import 'package:flutter/cupertino.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchRestaurantList();
  }

  late RestaurantListResult _restaurantList;
  late ResultState _state;
  String _message = '';

  RestaurantListResult get result => _restaurantList;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> _fetchRestaurantList() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurantList = await apiService.getRestaurantList();
      if (restaurantList.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantList = restaurantList;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
