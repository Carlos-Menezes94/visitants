import 'module.dart';
import 'module_injector.dart';

mixin QuickActionsMixin<M extends Module, T extends QuickActions<M>> {
  T get actions;
}

abstract class QuickActions<M extends Module> {
  ModuleInjector get injector => Module.get<M>().injector;
}
