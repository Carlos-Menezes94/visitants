import 'package:flutter/cupertino.dart';

class AppNavigator {
  final GlobalKey<NavigatorState> navigatorKey;

  AppNavigator(this.navigatorKey);

  void pushNamed<T extends Object?>(String routeName, {Object? arguments}) {
    navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState!.pop();
  }

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
      String routeName,
      {TO? result,
      Object? arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
      String routeName,
      {TO? result,
      Object? arguments}) {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!
          .popAndPushNamed(routeName, arguments: arguments);
    } else {
      throw Exception("O navigator está nulo");
    }
  }

  void popUntil(String route) {
    return navigatorKey.currentState?.popUntil(ModalRoute.withName(route));
  }
}
