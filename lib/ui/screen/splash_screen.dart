import 'package:dicoding_flutter_fundamental/ui/screen/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splash_page';

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(
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
