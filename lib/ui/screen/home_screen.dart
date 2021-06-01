import 'package:dicoding_flutter_fundamental/api/api_service.dart';
import 'package:dicoding_flutter_fundamental/common/navigation.dart';
import 'package:dicoding_flutter_fundamental/provider/restaurant_list_provider.dart';
import 'package:dicoding_flutter_fundamental/ui/screen/restaurant_list_screen.dart';
import 'package:dicoding_flutter_fundamental/ui/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigation.intent(SearchScreen.routeName);
            },
            color: Colors.grey,
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "title",
                child: Text(
                  'Restaurant',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .apply(color: Colors.black),
                  textAlign: TextAlign.start,
                ),
              ),
              Text(
                'Recommendation restaurant for you!',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .apply(color: Colors.black38),
              ),
              ChangeNotifierProvider<RestaurantProvider>(
                child: RestaurantListScreen(),
                create: (_) => RestaurantProvider(apiService: ApiService(),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
