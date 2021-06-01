import 'package:dicoding_flutter_fundamental/provider/restaurant_list_provider.dart';
import 'package:dicoding_flutter_fundamental/utils/ResultState.dart';
import 'package:dicoding_flutter_fundamental/widgets/empty_item.dart';
import 'package:dicoding_flutter_fundamental/widgets/loading_indicator.dart';
import 'package:dicoding_flutter_fundamental/widgets/restaurant_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantListScreen extends StatelessWidget {
  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantProvider>(builder: (context, state, _) {
      if (state.state == ResultState.Loading) {
        return LoadingIndicator();
      } else if (state.state == ResultState.HasData) {
        return RestaurantItem(restaurantList: state.result.restaurants);
      } else if (state.state == ResultState.NoData) {
        return EmptyItem();
      } else if (state.state == ResultState.Error) {
        return EmptyItem();
      } else {
        return Center(
          child: Text(''),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}
