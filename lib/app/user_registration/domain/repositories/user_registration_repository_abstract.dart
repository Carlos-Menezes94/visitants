import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';

abstract class UserRegistrationRepositoryAbstract {
  Future<Either<Failure, dynamic>> newUserRegistrationRepository(
      {required String email, required String password});
}
