import 'package:visitants/app/features/home/presentation/pages/home_page.dart';

import '../../../../module/module.dart';
import '../../../../module/module_injector.dart';
import 'home_injector.dart';

class HomeModule extends Module {
  static Module get to => Module.get<HomeModule>();

  @override
  ModuleInjector get injector => HomeInjector();

  @override
  String get initialRoute => HomePage.routeName;

  @override
  Map<String, RouteBuilder> get routes => {
        HomePage.routeName: (context, arguments) => HomePage(),
      };
}
