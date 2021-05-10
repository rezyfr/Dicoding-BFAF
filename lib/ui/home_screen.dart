import 'package:dicoding_flutter_fundamental/ui/restaurant_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Restaurant',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .apply(color: Colors.black),
                textAlign: TextAlign.start,
              ),
              Text(
                'Recommendation restaurant for you!',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .apply(color: Colors.black38),
              ),
              RestaurantList()
            ],
          ),
        ),
      ),
    );
  }
}
