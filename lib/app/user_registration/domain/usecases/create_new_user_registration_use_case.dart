import 'package:dartz/dartz.dart';
import 'package:visitants/app/user_registration/data/repositories/user_registration_repository_impl.dart';
import '../../../../../core/failure.dart';

class CreateNewUserRegistrationUseCase {
  final UserRegistrationRepositoryImpl repository;

  CreateNewUserRegistrationUseCase({required this.repository});
  Future<Either<Failure, dynamic>> createNewUserRegistrationUseCase(
      {required dynamic email, required dynamic password}) async {
    return repository.newUserRegistrationRepository(
        email: email, password: password);
  }
}
