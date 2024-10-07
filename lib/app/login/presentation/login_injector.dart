import 'package:visitants/app/login/presentation/stores/login_store.dart';

import '../../../../module/module_injector.dart';
import '../data/data_sources/login_data_source_impl.dart';
import '../data/repositories/login_repository_impl.dart';
import '../domain/usecases/logout_use_case.dart';
import '../domain/usecases/signin_login_use_case.dart';
import 'controllers/login_controller.dart';
import 'login_module.dart';

class LoginInjector extends ModuleInjector<LoginModule> {
  @override
  void controllers() {
    registerFactory(() => LoginController(
          store: get<LoginStore>(),
          signInLoginUseCase: LoginModule.to.injector.get<SignInLoginUseCase>(),
          logoutUseCase: LoginModule.to.injector.get<LogoutUseCase>(),
        ));
  }

  @override
  void core() {
    // registerFactory(() => FirebaseInstances(FirebaseAuth.instance));
  }

  @override
  void datasources() {
    registerFactory(() => LoginDataSourceImpl());
  }

  @override
  void repositories() {
    registerFactory(() => LoginRepositoryImpl(
        dataSource: LoginModule.to.injector.get<LoginDataSourceImpl>()));
  }

  @override
  void stores() {
    registerSingleton(LoginStore());
  }

  @override
  void usecases() {
    registerFactory(() => SignInLoginUseCase(
        repository: LoginModule.to.injector.get<LoginRepositoryImpl>()));
    registerFactory(() => LogoutUseCase(
        repository: LoginModule.to.injector.get<LoginRepositoryImpl>()));
  }
}
