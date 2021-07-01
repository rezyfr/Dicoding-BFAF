import 'package:dicoding_flutter_fundamental/api/api_service.dart';
import 'package:dicoding_flutter_fundamental/data/model/customer_review_result.dart';
import 'package:dicoding_flutter_fundamental/utils/result_state.dart';
import 'package:flutter/cupertino.dart';

class RestaurantReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantReviewProvider({required this.apiService});

  late CustomerReviewResult _reviewResponse;
  ResultState _state = ResultState.Start;
  String _message = '';

  CustomerReviewResult get result => _reviewResponse;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> searchRestaurant(id, name, review) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final response = await apiService.postReview(name, review, id);
      if (response.customerReviews.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _reviewResponse = response;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
