import 'package:dicoding_flutter_fundamental/api/api_service.dart';
import 'package:dicoding_flutter_fundamental/data/model/restaurant_search_result.dart';
import 'package:dicoding_flutter_fundamental/utils/result_state.dart';
import 'package:flutter/cupertino.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService});

  late RestaurantSearchResult _restaurantList;
  ResultState _state = ResultState.Start;
  String _message = '';

  RestaurantSearchResult get result => _restaurantList;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> searchRestaurant(query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurantList = await apiService.searchRestaurant(query);
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
