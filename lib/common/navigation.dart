import 'package:flutter/cupertino.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intent(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }

  static intentWithData(String routeName, Object arguments) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static Future<String?> intentAwaitResult(
      String routeName, Object arguments) async {
    return navigatorKey.currentState?.pushNamed(routeName);
  }

  static backWithResult(String state) => navigatorKey.currentState?.pop(state);

  static back() => navigatorKey.currentState?.pop();
}
