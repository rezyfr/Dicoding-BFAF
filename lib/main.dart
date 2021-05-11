import 'package:dicoding_flutter_fundamental/styles.dart';
import 'package:dicoding_flutter_fundamental/ui/screen/detail_screen.dart';
import 'package:dicoding_flutter_fundamental/ui/screen/home_screen.dart';
import 'package:dicoding_flutter_fundamental/ui/screen/splash_screen.dart';
import 'package:flutter/material.dart';

import 'model/restaurants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: myTextTheme
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        DetailScreen.routeName: (context) => DetailScreen(restaurant: ModalRoute.of(context)!.settings.arguments as Restaurants),
      },
    );
  }
}
