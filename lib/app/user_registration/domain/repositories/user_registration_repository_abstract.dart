import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../data/models/user_registered_data_model.dart';

abstract class UserRegistrationRepositoryAbstract {
  Future<Either<Failure, dynamic>> newUserRegistrationRepository(
      {required UserRegisteredDataModel userRegisteredDataModel});
}
