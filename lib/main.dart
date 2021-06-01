import 'package:dicoding_flutter_fundamental/common/styles.dart';
import 'package:dicoding_flutter_fundamental/provider/restaurant_detail_provider.dart';
import 'package:dicoding_flutter_fundamental/provider/restaurant_review_provider.dart';
import 'package:dicoding_flutter_fundamental/provider/restaurant_search_provider.dart';
import 'package:dicoding_flutter_fundamental/ui/screen/add_review_screen.dart';
import 'package:dicoding_flutter_fundamental/ui/screen/detail_screen.dart';
import 'package:dicoding_flutter_fundamental/ui/screen/home_screen.dart';
import 'package:dicoding_flutter_fundamental/ui/screen/search_screen.dart';
import 'package:dicoding_flutter_fundamental/ui/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/api_service.dart';
import 'common/navigation.dart';
import 'ui/screen/detail_screen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primaryColor,
        textTheme: myTextTheme,
        accentColor: secondaryColor,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        DetailScreen.routeName: (context) =>
            ChangeNotifierProvider<RestaurantDetailProvider>(
              child: DetailScreen(),
              create: (_) => RestaurantDetailProvider(
                  apiService: ApiService(),
                  restaurantId:
                      ModalRoute.of(context)!.settings.arguments as String),
            ),
        SearchScreen.routeName: (context) =>
            ChangeNotifierProvider<RestaurantSearchProvider>(
              create: (_) => RestaurantSearchProvider(
                apiService: ApiService(),
              ),
              child: SearchScreen(),
            ),
        AddReviewScreen.routeName: (context) => ChangeNotifierProvider(
              create: (_) => RestaurantReviewProvider(apiService: ApiService()),
              child: AddReviewScreen(
                restaurantId: ModalRoute.of(context)!.settings.arguments as String,
              ),
            ),
      },
    );
  }
}
