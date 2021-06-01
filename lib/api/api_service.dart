import 'dart:convert';

import 'package:dicoding_flutter_fundamental/data/model/customer_review.dart';
import 'package:dicoding_flutter_fundamental/data/model/customer_review_result.dart';
import 'package:dicoding_flutter_fundamental/data/model/restaurant_detail_result.dart';
import 'package:dicoding_flutter_fundamental/data/model/restaurant_list_result.dart';
import 'package:dicoding_flutter_fundamental/data/model/restaurant_search_result.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantListResult> getRestaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + "/list"));
    if (response.statusCode == 200) {
      return RestaurantListResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetailResult> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + "/detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantSearchResult> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + "/search?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantSearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search restaurant');
    }
  }

  Future<CustomerReviewResult> postReview(
      String name, String review, String id) async {
    var reviewJson = json.encode(toJson(id, name, review));
    final response = await http.post(
      Uri.parse(_baseUrl + "/review"),
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': '12345',
      },
      body: reviewJson,
    );
    if (response.statusCode == 200) {
      return CustomerReviewResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post review');
    }
  }
}
