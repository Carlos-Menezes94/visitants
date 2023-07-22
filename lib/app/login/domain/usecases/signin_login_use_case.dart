import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/failure.dart';
import '../../data/repositories/login_repository_impl.dart';

class SignInLoginUseCase {
  final LoginRepositoryImpl repository;

  SignInLoginUseCase({required this.repository});

  Future<Either<Failure, User>> signinLogin(
      {required String password, required String email}) async {
    return repository.signInLogin(email: email, password: password);
  }
}
