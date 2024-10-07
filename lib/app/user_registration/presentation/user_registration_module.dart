import 'package:visitants/app/user_registration/presentation/pages/user_registration_page.dart';
import 'package:visitants/app/user_registration/presentation/user_registration_injector.dart';
import 'package:visitants/app/user_registration/presentation/user_registration_quick_actions.dart';
import '../../../../module/module.dart';
import '../../../../module/module_injector.dart';
import '../../../../module/quick_actions.dart';

class UserRegistrationModule extends Module
    with QuickActionsMixin<UserRegistrationModule, UserRegistrationQuickActions> {
  static UserRegistrationModule get to =>
      Module.get<UserRegistrationModule>() as UserRegistrationModule;

  @override
  ModuleInjector get injector => UserRegistrationInjector();

  @override
  String get initialRoute => UserRegistrationPage.routeName;

  @override
  UserRegistrationQuickActions get actions => UserRegistrationQuickActions();

  @override
  Map<String, RouteBuilder> get routes => {
        UserRegistrationPage.routeName: (context, arguments) =>
            const UserRegistrationPage(),
      };
}
