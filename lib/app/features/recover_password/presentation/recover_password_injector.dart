import 'package:visitants/app/features/recover_password/presentation/stores/recover_password_store.dart';

import '../../../../module/module_injector.dart';

import 'controllers/recover_password_controller.dart';
import 'recover_password_module.dart';

class RecoverPasswordInjector extends ModuleInjector<RecoverPasswordModule> {
  @override
  void controllers() {
    registerFactory(() => RecoverPasswordController());
  }

  @override
  void core() {}

  @override
  void datasources() {}

  @override
  void repositories() {}

  @override
  void stores() {
    registerSingleton(RecoverPasswordStore());
  }

  @override
  void usecases() {}
}
