import 'package:dartz/dartz.dart';
import 'package:visitants/app/user_registration/data/repositories/user_registration_repository_impl.dart';
import '../../../../../core/failure.dart';
import '../../data/models/user_registered_data_model.dart';

class CreateNewUserRegistrationUseCase {
  final UserRegistrationRepositoryImpl repository;

  CreateNewUserRegistrationUseCase({required this.repository});
  Future<Either<Failure, dynamic>> createNewUserRegistrationUseCase(
      {required UserRegisteredDataModel userRegisteredDataModel}) async {
    return repository.newUserRegistrationRepository(
        userRegisteredDataModel: userRegisteredDataModel);
  }
}
