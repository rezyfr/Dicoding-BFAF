import 'dart:convert';

import 'package:dicoding_flutter_fundamental/api/api_service.dart';
import 'package:dicoding_flutter_fundamental/data/model/restaurant_detail_result.dart';
import 'package:dicoding_flutter_fundamental/data/model/restaurant_list_result.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("Api service test", () {

    late MockApiService api;
    setUp(() {
      api = MockApiService();
    });

    test('Get restaurant list', () async {
      when(api.getRestaurantList()).thenAnswer((_) async {
        var result =
            await rootBundle.loadString('assets/local_restaurant.json');

        return RestaurantListResult.fromJson(json.decode(result));
      });

      var response = await api.getRestaurantList();
      var firstRestaurant = response.restaurants[0];
      expect(firstRestaurant.name, "Melting Pot");
    });

    test('Get restaurant by id', () async {
      String id = "rqdv5juczeskfw1e867";
      when(api.getRestaurantDetail(id)).thenAnswer((_) async {
        var result =
            await rootBundle.loadString('assets/local_restaurant_detail.json');

        return RestaurantDetailResult.fromJson(json.decode(result));
      });
      final response = await api.getRestaurantDetail(id);
      var restaurant = response.restaurant;
      expect(restaurant.name, "Melting Pot");
      expect(response.error, false);
    });
  });
}
