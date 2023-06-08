import 'package:visitants/app/features/home/presentation/stores/home_store.dart';
import '../../../../module/module_injector.dart';

import 'controllers/home_controller.dart';
import 'home_module.dart';

class HomeInjector extends ModuleInjector<HomeModule> {
  @override
  void controllers() {
    registerFactory(() => HomeController(
          store: get<HomeStore>(),
        ));
  }

  @override
  void core() {
    // registerFactory(() => FirebaseInstances(FirebaseAuth.instance));
  }

  @override
  void datasources() {
    // registerFactory(() => LoginDataSourceImpl());
  }

  @override
  void repositories() {
    // registerFactory(() => LoginRepositoryImpl(
    //     dataSource: HomeModule.to.injector.get<LoginDataSourceImpl>()));
  }

  @override
  void stores() {
    registerSingleton(HomeStore());
  }

  @override
  void usecases() {
    // registerFactory(() => SignInLoginUseCase(
    //     repository: HomeModule.to.injector.get<LoginRepositoryImpl>()));
  }
}
