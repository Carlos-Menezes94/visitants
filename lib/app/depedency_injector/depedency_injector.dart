import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:visitants/app/features/login/data/data_sources/login_data_source_impl.dart';
import 'package:visitants/app/features/login/data/repositories/login_repository_impl.dart';

import '../../core/firebase_instances.dart';
import '../features/login/domain/usecases/signin_login_use_case.dart';
import '../features/login/presentation/controllers/login_controller.dart';
import '../features/login/presentation/stores/login_store.dart';

class DepedencyInjector {
  static void start() {
    GetIt getIt = GetIt.instance;
    getIt.registerSingleton(FirebaseInstances(FirebaseAuth.instance));

    getIt.registerFactory(() => LoginDataSourceImpl(
        authFirebase: getIt.get<FirebaseInstances>().getFireStoreInstance));
    getIt.registerFactory(() =>
        LoginRepositoryImpl(dataSource: getIt.get<LoginDataSourceImpl>()));

    getIt.registerFactory(
        () => SignInLoginUseCase(repository: getIt.get<LoginRepositoryImpl>()));

    getIt.registerSingleton(LoginStore());

    getIt.registerFactory(() => LoginController(
        store: getIt.get<LoginStore>(),
        signInLoginUseCase: getIt.get<SignInLoginUseCase>()));
  }
}
