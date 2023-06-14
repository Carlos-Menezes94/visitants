import 'package:visitants/app/features/home/data/data_sources/home_data_source_impl.dart';
import 'package:visitants/app/features/home/data/repositories/home_repository_impl.dart';
import 'package:visitants/app/features/home/domain/usecases/create_new_registration_visitor_use_case.dart';
import 'package:visitants/app/features/home/domain/usecases/get_list_visitor_usecase.dart';
import 'package:visitants/app/features/home/presentation/stores/home_store.dart';
import 'package:visitants/app/features/login/presentation/login_module.dart';
import 'package:visitants/app/features/login/presentation/stores/login_store.dart';
import '../../../../module/module_injector.dart';

import 'controllers/home_controller.dart';
import 'home_module.dart';

class HomeInjector extends ModuleInjector<HomeModule> {
  @override
  void controllers() {
    registerFactory(() => HomeController(
          store: get<HomeStore>(),
          loginStore: LoginModule.to.injector.get<LoginStore>(),
          getListVisitorUsecase:
              HomeModule.to.injector.get<GetListVisitorUsecase>(),
          createNewRegistrationVisitorUseCase:
              HomeModule.to.injector.get<CreateNewRegistrationVisitorUseCase>(),
        ));
  }

  @override
  void core() {
    // registerFactory(() => FirebaseInstances(FirebaseAuth.instance));
  }

  @override
  void datasources() {
    registerFactory(() => HomeDataSourceImpl());
  }

  @override
  void repositories() {
    registerFactory(() => HomeRepositoryImpl(
        dataSource: HomeModule.to.injector.get<HomeDataSourceImpl>()));
  }

  @override
  void stores() {
    registerSingleton(HomeStore());
  }

  @override
  void usecases() {
    registerFactory(() => GetListVisitorUsecase(
        repository: HomeModule.to.injector.get<HomeRepositoryImpl>()));
    registerFactory(() => CreateNewRegistrationVisitorUseCase(
        repository: HomeModule.to.injector.get<HomeRepositoryImpl>()));
  }
}
