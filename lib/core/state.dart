import 'package:flutter/material.dart';
import 'package:visitants/core/store.dart';

import '../module/module.dart';
import 'controller.dart';

abstract class StatelessController<M extends Module, C extends Controller>
    extends StatelessWidget {
  StatelessController({super.key}) {
    controller = Module.get<M>().injector.get<C>();
  }

  late final C controller;
}

abstract class StateController<M extends Module, T extends StatefulWidget,
    C extends Controller> extends State<T> {
  StateController() {
    controller = Module.get<M>().injector.get<C>();
  }

  late final C controller;
}

abstract class StateStore<M extends Module, T extends StatefulWidget,
    S extends Store> extends State<T> {
  StateStore() {
    store = Module.get<M>().injector.get<S>();
  }

  late final S store;
}

abstract class StatePage<M extends Module, T extends StatefulWidget,
    C extends Controller, S extends Store> extends State<T> {
  StatePage() {
    controller = Module.get<M>().injector.get<C>();
    store = Module.get<M>().injector.get<S>();
  }

  late final C controller;
  late final S store;
}
