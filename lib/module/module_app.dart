import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'module.dart';

class ModuleApp extends StatefulWidget {
  const ModuleApp({
    super.key,
    required this.mainModule,
    required this.childModules,
    required this.app,
  });

  final Module mainModule;
  final List<Module> childModules;
  final Widget Function(Widget home) app;

  @override
  State<ModuleApp> createState() => _ModuleAppState();
}

class _ModuleAppState extends State<ModuleApp> {
  late Navigator navigator;
  late Widget mainModuleWidget;

  @override
  void initState() {
    GetIt.I.registerSingleton(widget.mainModule,
        instanceName: widget.mainModule.runtimeType.toString());

    for (final module in widget.childModules) {
      GetIt.I.registerSingleton(module,
          instanceName: module.runtimeType.toString());
    }
    widget.mainModule.start();

    mainModuleWidget = widget.mainModule
        .widget(context, onRouteNotFound: searchRouteInOtherModules);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.app(mainModuleWidget);
  }

  RouteBuilder? searchRouteInOtherModules(RouteSettings settings) {
    RouteBuilder? routeBuilder;

    int index = 0;
    while (routeBuilder == null && index < widget.childModules.length) {
      routeBuilder =
          widget.childModules.elementAt(index).getRoute(settings.name!);
      if (routeBuilder != null) {
        widget.childModules.elementAt(index).start();
      }
      index++;
    }

    return routeBuilder;
  }
}
