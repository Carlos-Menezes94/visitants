import 'package:get_it/get_it.dart';
import 'package:visitants/features/login/presentation/controllers/login_controller.dart';

import '../../features/login/presentation/stores/login_store.dart';

class DepedencyInjector {
  static void start() {
    GetIt getIt = GetIt.instance;

    getIt.registerSingleton(LoginStore());

    getIt.registerFactory(() => LoginController(store: LoginStore()));
  }
}
