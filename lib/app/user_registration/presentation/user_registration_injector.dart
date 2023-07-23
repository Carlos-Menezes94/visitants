import 'package:visitants/app/user_registration/presentation/stores/user_registration_store.dart';

import '../../../../module/module_injector.dart';

import '../data/data_sources/user_registration_data_source_impl.dart';
import '../data/repositories/user_registration_repository_impl.dart';
import '../domain/usecases/create_new_user_registration_use_case.dart';
import 'controllers/user_registration_controller.dart';
import 'user_registration_module.dart';

class UserRegistrationInjector extends ModuleInjector<UserRegistrationModule> {
  @override
  void controllers() {
    registerFactory(() => UserRegistrationController(
          store:
              UserRegistrationModule.to.injector.get<UserRegistrationStore>(),
          createNewUserRegistrationUseCase: UserRegistrationModule.to.injector
              .get<CreateNewUserRegistrationUseCase>(),
        ));
  }

  @override
  void core() {}

  @override
  void datasources() {
    registerFactory(() => UserRegistrationDataSourceImpl());
  }

  @override
  void repositories() {
    registerFactory(() => UserRegistrationRepositoryImpl(
        dataSourceImpl: UserRegistrationModule.to.injector
            .get<UserRegistrationDataSourceImpl>()));
  }

  @override
  void stores() {
    registerSingleton(UserRegistrationStore());
  }

  @override
  void usecases() {
    registerFactory(() => CreateNewUserRegistrationUseCase(
        repository: get<UserRegistrationRepositoryImpl>()));
  }
}
