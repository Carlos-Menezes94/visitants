import 'package:visitants/app/features/visitor_registration/data/data_sources/visitor_registration_data_source_impl.dart';
import 'package:visitants/app/features/visitor_registration/data/repositories/visitor_registration_repository_impl.dart';
import 'package:visitants/app/features/visitor_registration/domain/use_cases/create_new_registration_visitor_use_case.dart';
import 'package:visitants/app/features/visitor_registration/presentation/stores/visitor_registration_store.dart';
import '../../../../module/module_injector.dart';

import 'controllers/visitor_registration_controller.dart';
import 'visitor_registration_module.dart';

class VisitorRegistrationInjector
    extends ModuleInjector<VisitorRegistrationModule> {
  @override
  void controllers() {
    registerFactory(() => VisitorRegistrationController(
        usecase: VisitorRegistrationModule.to.injector
            .get<CreateNewRegistrationVisitorUseCase>(),
        store: get<VisitorRegistrationStore>()));
  }

  @override
  void core() {}

  @override
  void datasources() {
    registerFactory(() => VisitorRegistrationDataSourceImpl());
  }

  @override
  void repositories() {
    registerFactory(() => VisitorRegistrationRepositoryImpl(
        dataSource: VisitorRegistrationModule.to.injector
            .get<VisitorRegistrationDataSourceImpl>()));
  }

  @override
  void stores() {
    registerSingleton(VisitorRegistrationStore());
  }

  @override
  void usecases() {
    registerFactory(() => CreateNewRegistrationVisitorUseCase(
        repository: VisitorRegistrationModule.to.injector
            .get<VisitorRegistrationRepositoryImpl>()));
  }
}
