import 'dart:async';

import 'package:flutter/material.dart';

import 'module.dart';

abstract class ModuleInjector<M extends Module> {
  final _injectionsDispose = <void Function()>[];
  // ignore: invalid_use_of_visible_for_testing_member
  final _getit = Module.get<M>().privateDependencyManager;

  void core();
  void datasources();
  void repositories();
  void usecases();
  void stores();
  void controllers();

  void register() {
    stores();
    core();
    datasources();
    repositories();
    usecases();
    controllers();
  }

  void registerFactory<T extends Object>(T Function() factoryFunc,
      {String? instanceName}) {
    if (_getit.isRegistered<T>()) return;
    _getit.registerFactory<T>(factoryFunc);
    _injectionsDispose.add(() => _unregisterInjectable<T>());
  }

  void registerSingleton<T extends Object>(T instance, {String? instanceName}) {
    if (_getit.isRegistered<T>()) return;
    _getit.registerSingleton<T>(instance);
    _injectionsDispose.add(() => _unregisterInjectable<T>());
  }

  void registerLazySingleton<T extends Object>(T Function() factoryFunc,
      {String? instanceName}) {
    if (_getit.isRegistered<T>()) return;
    _getit.registerLazySingleton<T>(factoryFunc);
    _injectionsDispose.add(() => _unregisterInjectable<T>());
  }

  FutureOr<dynamic> _unregisterInjectable<T extends Object>() {
    return _getit.unregister<T>();
  }

  bool isRegistered<T extends Object>() {
    return _getit.isRegistered<T>();
  }

  int get internalInjectorHashCode => _getit.hashCode;

  T get<T extends Object>() {
    try {
      if (!Module.get<M>().isStarted) Module.get<M>().start();
      if (_getit.isRegistered<T>()) return _getit.get<T>();
      throw Exception();
    } catch (e) {
      final logMessage =
          '$T is not registered in $runtimeType.\nDid you forget to register it?\nDid you register it in a [ModuleInjector] of other [Module] than $M?';
      debugPrint(logMessage);
      throw Exception(logMessage);
    }
  }
}
