import 'package:dartz/dartz.dart';

import '../../../../../core/failure.dart';
import '../../data/repositories/login_repository_impl.dart';

class LogoutUseCase {
  final LoginRepositoryImpl repository;

  LogoutUseCase({required this.repository});

  Future<Either<Failure, String>> logoutLoginUser(
      {required String password, required String email}) async {
    return repository.logoutLogin();
  }
}
