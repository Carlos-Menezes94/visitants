import 'package:visitants/app/features/login/presentation/login_injector.dart';
import 'package:visitants/app/features/login/presentation/pages/login_page.dart';
import 'package:visitants/app/features/login/presentation/login_quick_actions.dart';

import '../../../../module/module.dart';
import '../../../../module/module_injector.dart';
import '../../../../module/quick_actions.dart';


class LoginModule extends Module
    with QuickActionsMixin<LoginModule, LoginQuickActions> {
  static LoginModule get to => Module.get<LoginModule>() as LoginModule;

  @override
  ModuleInjector get injector => LoginInjector();

  @override
  String get initialRoute => LoginPage.routeName;

  @override
  Future<void> didStart() async {
    LoginModule.to.start();

    return super.didStart();
  }

  @override
  LoginQuickActions get actions => LoginQuickActions();

  @override
  Map<String, RouteBuilder> get routes => {
        LoginPage.routeName: (context, arguments) => LoginPage(),
      };
}
