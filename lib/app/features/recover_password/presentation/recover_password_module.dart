import 'package:visitants/app/features/recover_password/presentation/pages/recover_password_page.dart';
import 'package:visitants/app/features/recover_password/presentation/recover_password_injector.dart';
import 'package:visitants/app/features/recover_password/presentation/recover_password_quick_actions.dart';

import '../../../../module/module.dart';
import '../../../../module/module_injector.dart';
import '../../../../module/quick_actions.dart';

class RecoverPasswordModule extends Module
    with QuickActionsMixin<RecoverPasswordModule, RecoverPasswordQuickActions> {
  static RecoverPasswordModule get to =>
      Module.get<RecoverPasswordModule>() as RecoverPasswordModule;

  @override
  ModuleInjector get injector => RecoverPasswordInjector();

  @override
  String get initialRoute => RecoverPasswordPage.routeName;

  @override
  RecoverPasswordQuickActions get actions => RecoverPasswordQuickActions();

  @override
  Map<String, RouteBuilder> get routes => {
        RecoverPasswordPage.routeName: (context, arguments) =>
              const RecoverPasswordPage(),
      };
}
