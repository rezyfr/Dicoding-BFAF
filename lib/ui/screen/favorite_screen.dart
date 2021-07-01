import 'package:dicoding_flutter_fundamental/data/model/restaurant_list.dart';
import 'package:dicoding_flutter_fundamental/provider/database_provider.dart';
import 'package:dicoding_flutter_fundamental/utils/result_state.dart';
import 'package:dicoding_flutter_fundamental/widgets/platform_widget.dart';
import 'package:dicoding_flutter_fundamental/widgets/restaurant_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  static var routeName = '/favorite_screen';
  static const String favoritesTitle = 'Bookmarks';

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
                  'Favorite Restaurant',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .apply(color: Colors.black),
                  textAlign: TextAlign.start,
                ),
              ),
              Consumer<DatabaseProvider>(
                builder: (context, provider, child) {
                  if (provider.state == ResultState.HasData) {
                    return RestaurantItem(restaurantList: provider.favorites);
                  } else {
                    return Center(
                      child: Text(provider.message),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
