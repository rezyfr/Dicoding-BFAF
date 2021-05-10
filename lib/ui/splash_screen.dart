import 'package:dicoding_flutter_fundamental/ui/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splash_page';

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushNamed(
        context,
        HomeScreen.routeName,
      ),
    );
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset(
            'images/restaurant.png'
          ),
        ),
      ),
    );
  }
}
