import 'package:visitants/app/features/home/presentation/home_quick_actions.dart';
import 'package:visitants/app/features/home/presentation/pages/home_page.dart';
import 'package:visitants/app/features/home/presentation/pages/list_visitors_page.dart';
import 'package:visitants/app/features/home/presentation/pages/visitor_registration_page.dart';
import 'package:visitants/module/quick_actions.dart';

import '../../../../module/module.dart';
import '../../../../module/module_injector.dart';
import 'home_injector.dart';

class HomeModule extends Module
    with QuickActionsMixin<HomeModule, HomeQuickActions> {
  static Module get to => Module.get<HomeModule>() as HomeModule;

  @override
  ModuleInjector get injector => HomeInjector();

  @override
  String get initialRoute => HomePage.routeName;

  @override
  Map<String, RouteBuilder> get routes => {
        HomePage.routeName: (context, arguments) => const HomePage(),
        ListVisitorPage.routeName: (context, arguments) => const ListVisitorPage(),
        VisitorRegistrationPage.routeName: (context, arguments) =>
            const VisitorRegistrationPage()
      };

  @override
  HomeQuickActions get actions => HomeQuickActions();
}
