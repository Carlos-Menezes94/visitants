import 'package:visitants/app/features/home/data/repositories/home_repository_impl.dart';
import 'package:visitants/app/features/home/domain/usecases/create_new_registration_visitor_use_case.dart';
import 'package:visitants/app/features/home/domain/usecases/get_list_visitor_usecase.dart';
import 'package:visitants/app/features/home/presentation/stores/home_store.dart';
import 'package:visitants/app/features/login/presentation/login_module.dart';
import 'package:visitants/app/features/login/presentation/stores/login_store.dart';
import '../../../../core/local_storage/local_storage_services.dart';
import '../../../../module/module_injector.dart';

import '../data/data_sources/local/home_local_data_source_impl.dart';
import '../data/data_sources/remote/home_remote_data_source_impl.dart';
import '../domain/usecases/admin_check_in_use_case.dart';
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
          adminCheckInUseCase:
              HomeModule.to.injector.get<AdminCheckInUseCase>(),
        ));
  }

  @override
  void core() {
    registerSingleton(LocalStorageService());
  }

  @override
  void datasources() {
    registerFactory(() => HomeRemoteDataSourceImpl(
        homeLocalDataSourceImpl:
            HomeModule.to.injector.get<HomeLocalDataSourceImpl>(),
        localStorage: HomeModule.to.injector.get<LocalStorageService>()));
    registerFactory(() => HomeLocalDataSourceImpl(
        localStorage: HomeModule.to.injector.get<LocalStorageService>()));
  }

  @override
  void repositories() {
    registerFactory(() => HomeRepositoryImpl(
        dataSourceRemote:
            HomeModule.to.injector.get<HomeRemoteDataSourceImpl>(),
        dataSourceLocal:
            HomeModule.to.injector.get<HomeLocalDataSourceImpl>()));
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
    registerFactory(() => AdminCheckInUseCase(
        repository: HomeModule.to.injector.get<HomeRepositoryImpl>()));
  }
}
