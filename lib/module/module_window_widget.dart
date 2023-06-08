import 'package:flutter/material.dart';

import 'module.dart';

class ModuleWindow<M extends Module> extends StatefulWidget {
  const ModuleWindow({super.key, required this.builder});
  final WidgetBuilder builder;
  @override
  State<ModuleWindow> createState() => _ModuleWindowState<M>();
}

class _ModuleWindowState<M extends Module> extends State<ModuleWindow> {
  @override
  void initState() {
    super.initState();
    if (!Module.get<M>().isStarted) Module.get<M>().start();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
