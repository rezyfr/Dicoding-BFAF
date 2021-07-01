import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:dicoding_flutter_fundamental/common/styles.dart';
import 'package:dicoding_flutter_fundamental/data/db/database_helper.dart';
import 'package:dicoding_flutter_fundamental/data/preferences/preferences_helper.dart';
import 'package:dicoding_flutter_fundamental/provider/database_provider.dart';
import 'package:dicoding_flutter_fundamental/provider/preferences_provider.dart';
import 'package:dicoding_flutter_fundamental/provider/restaurant_detail_provider.dart';
import 'package:dicoding_flutter_fundamental/provider/restaurant_list_provider.dart';
import 'package:dicoding_flutter_fundamental/provider/restaurant_review_provider.dart';
import 'package:dicoding_flutter_fundamental/provider/restaurant_search_provider.dart';
import 'package:dicoding_flutter_fundamental/provider/scheduling_provider.dart';
import 'package:dicoding_flutter_fundamental/ui/screen/add_review_screen.dart';
import 'package:dicoding_flutter_fundamental/ui/screen/detail_screen.dart';
import 'package:dicoding_flutter_fundamental/ui/screen/favorite_screen.dart';
import 'package:dicoding_flutter_fundamental/ui/screen/home_screen.dart';
import 'package:dicoding_flutter_fundamental/ui/screen/search_screen.dart';
import 'package:dicoding_flutter_fundamental/ui/screen/settings_screen.dart';
import 'package:dicoding_flutter_fundamental/ui/screen/splash_screen.dart';
import 'package:dicoding_flutter_fundamental/utils/background_service.dart';
import 'package:dicoding_flutter_fundamental/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/api_service.dart';
import 'common/navigation.dart';
import 'ui/screen/detail_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<RestaurantSearchProvider>(
          create: (_) => RestaurantSearchProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantReviewProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
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
                    create: (_) => RestaurantDetailProvider(
                      apiService: ApiService(),
                      restaurantId:
                          ModalRoute.of(context)!.settings.arguments as String,
                    ),
                    child: DetailScreen(),
                  ),
              SearchScreen.routeName: (context) => SearchScreen(),
              AddReviewScreen.routeName: (context) => AddReviewScreen(
                  restaurantId:
                      ModalRoute.of(context)!.settings.arguments as String),
              SettingsScreen.routeName: (context) => SettingsScreen(),
              FavoriteScreen.routeName: (context) => FavoriteScreen(),
            },
          );
        },
      ),
    );
  }
}
