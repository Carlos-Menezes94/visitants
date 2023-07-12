import 'package:visitants/app/features/recover_password/presentation/stores/recover_password_store.dart';

import '../../../../module/module_injector.dart';

import '../data/datasources/recover_password_data_source_impl.dart';
import '../data/repositories/recover_password_repository_impl.dart';
import '../domain/usecases/recover_password_usecase.dart';
import 'controllers/recover_password_controller.dart';
import 'recover_password_module.dart';

class RecoverPasswordInjector extends ModuleInjector<RecoverPasswordModule> {
  @override
  void controllers() {
    registerFactory(() => RecoverPasswordController(
          usecase: get<RecoverPasswordUseCase>(),
          store: get<RecoverPasswordStore>(),
        ));
  }

  @override
  void core() {}

  @override
  void datasources() {
    registerFactory(() => RecoverPasswordDataSourceImpl());
  }

  @override
  void repositories() {
    registerFactory(() => RecoverPasswordRepositoryImpl(
        recoverPasswordDataSourceImpl: get<RecoverPasswordDataSourceImpl>()));
  }

  @override
  void stores() {
    registerSingleton(RecoverPasswordStore());
  }

  @override
  void usecases() {
    registerFactory(() => RecoverPasswordUseCase(
        repository: get<RecoverPasswordRepositoryImpl>()));
  }
}
