import 'package:visitants/app/features/visitor_registration/presentation/pages/visitor_registration_page.dart';
import 'package:visitants/app/features/visitor_registration/presentation/visitor_registration_quick_actions.dart';
import 'package:visitants/module/quick_actions.dart';

import '../../../../module/module.dart';
import '../../../../module/module_injector.dart';
import 'visitor_registration_injector.dart';

class VisitorRegistrationModule extends Module
    with
        QuickActionsMixin<VisitorRegistrationModule,
            VisitorRegistrationQuickActions> {
  static Module get to =>
      Module.get<VisitorRegistrationModule>() as VisitorRegistrationModule;

  @override
  ModuleInjector get injector => VisitorRegistrationInjector();

  @override
  String get initialRoute => VisitorRegistrationPage.routeName;
  @override
  VisitorRegistrationQuickActions get actions =>
      VisitorRegistrationQuickActions();
  @override
  Map<String, RouteBuilder> get routes => {
        VisitorRegistrationPage.routeName: (context, arguments) =>
            VisitorRegistrationPage(),
      };
}
