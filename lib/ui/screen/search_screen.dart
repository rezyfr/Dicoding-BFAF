import 'package:dicoding_flutter_fundamental/provider/restaurant_search_provider.dart';
import 'package:dicoding_flutter_fundamental/utils/result_state.dart';
import 'package:dicoding_flutter_fundamental/widgets/empty_search.dart';
import 'package:dicoding_flutter_fundamental/widgets/loading_indicator.dart';
import 'package:dicoding_flutter_fundamental/widgets/restaurant_item.dart';
import 'package:dicoding_flutter_fundamental/widgets/start_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  static String routeName = '/search_screen';
  final TextEditingController _queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "title",
                child: Text(
                  'Search',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .apply(color: Colors.black),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: _queryController,
                  onSubmitted: (String query) {
                    Provider.of<RestaurantSearchProvider>(context,
                            listen: false)
                        .searchRestaurant(query);
                  },
                  decoration: InputDecoration(
                    labelText: 'Find restaurants...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2.0),
                    ),
                  ),
                ),
              ),
              Consumer<RestaurantSearchProvider>(builder: (context, state, _) {
                if (state.state == ResultState.Loading) {
                  return LoadingIndicator();
                } else if (state.state == ResultState.HasData) {
                  return RestaurantItem(
                    restaurantList: state.result.restaurants,
                  );
                } else if (state.state == ResultState.NoData) {
                  return EmptySearch(query: _queryController.text);
                } else if (state.state == ResultState.Error) {
                  return Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return StartSearch();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
