import 'package:dartz/dartz.dart';
import 'package:visitants/app/features/login/data/models/login_model.dart';
import 'package:visitants/app/features/login/data/repositories/login_repository_impl.dart';

import '../../../../../core/failure.dart';

class SignInLoginUseCase {
  final LoginRepositoryImpl repository;

  SignInLoginUseCase({required this.repository});

  Future<Either<Failure, String>> signinLogin(
      {required String password, required String email}) async {
    return repository.signInLogin(email: email, password: password);
  }
}