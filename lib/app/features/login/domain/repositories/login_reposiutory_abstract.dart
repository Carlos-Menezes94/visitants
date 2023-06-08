import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/failure.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/login_model.dart';

abstract class LoginRepositoryAbstract {
  Future<Either<Failure, User>> signInLogin(
      {required String password, required String email});
  Future<Either<Failure, String>> registerLogin(
      {required String password, required String email});
        Future<Either<Failure, String>> logoutLogin();
}
