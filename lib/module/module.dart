import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:visitants/module/module_injector.dart';

import '../core/app_navigator.dart';

typedef RouteBuilder = Widget Function(BuildContext context, dynamic arguments);

abstract class Module extends Object {
  Module() {
    _moduleNavigator = Navigator(
      key: navigatorKey,
      onGenerateRoute: onGenerateRoute,
    );
    navigator = AppNavigator(navigatorKey);
    privateDependencyManager = GetIt.asNewInstance();
  }

  late final Navigator _moduleNavigator;
  final navigatorKey = GlobalKey<NavigatorState>();
  RouteBuilder? Function(RouteSettings)? onRouteNotFound;

  void start() {
    if (_isStarted) {
      debugPrint('\n--- $runtimeType - Is already started ---\n');
    } else {
      injector.register();
      _isStarted = true;
      debugPrint('\n/// $runtimeType - Started ///\n');
      didStart();
    }
  }

  Future<void> didStart() async {}

  void stop() {
    _isStarted = false;
    _isStopped = true;
  }

  bool _isStarted = false;
  bool _isStopped = false;

  bool get isStarted => _isStarted;
  bool get isStopped => _isStopped;

  String get initialRoute;

  Map<String, RouteBuilder> get routes;

  ModuleInjector get injector;

  RouteBuilder? getRoute(String name) => routes[name];

  late final AppNavigator navigator;
  
  @visibleForTesting
  late final GetIt privateDependencyManager;

  static Module get<T extends Module>() =>
      GetIt.I.get<Module>(instanceName: T.toString());

  Widget widget(BuildContext context,
      {RouteBuilder? Function(RouteSettings)? onRouteNotFound}) {
    this.onRouteNotFound = onRouteNotFound;
    if (!isStarted) start();
    return Builder(builder: (context) => _moduleNavigator);
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    RouteBuilder? routeBuilder;

    if (settings.name == '/') {
      routeBuilder = getRoute(initialRoute);
    } else {
      routeBuilder = getRoute(settings.name!);

      if (routeBuilder == null && onRouteNotFound != null) {
        routeBuilder = onRouteNotFound!(settings);
      }
    }

    routeBuilder ??= getFallBackRoute(settings);

    return MaterialPageRoute(
        settings: settings,
        builder: (_) => Builder(
            builder: (context) => routeBuilder!(context, settings.arguments)));
  }

  RouteBuilder getFallBackRoute(RouteSettings settings) {
    return (context, _) => Scaffold(
          appBar: AppBar(
            title: const Text('Route not found '),
          ),
          body: Center(
            child: SizedBox(
              width: 300,
              child: Text(
                'The route \'${settings.name}\' was not found in the module $runtimeType.\nDid your forget to register it in your module ?\nAre you using the correct [Module] to navigate?',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
  }

}

