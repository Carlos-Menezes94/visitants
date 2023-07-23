import 'package:dartz/dartz.dart';
import 'package:visitants/app/user_registration/data/data_sources/user_registration_data_source_impl.dart';
import 'package:visitants/app/user_registration/domain/repositories/user_registration_repository_abstract.dart';
import '../../../../core/failure.dart';

class UserRegistrationRepositoryImpl
    implements UserRegistrationRepositoryAbstract {
  final UserRegistrationDataSourceImpl dataSourceImpl;

  UserRegistrationRepositoryImpl({required this.dataSourceImpl});
  @override
  Future<Either<Failure, dynamic>> newUserRegistrationRepository(
      {required String email, required String password}) async {
    try {
      final response = await dataSourceImpl.newUserRegistration(
          email: email, password: password);
      if (response.success) {
        return Right(response.data);
      } else {
        return Right(throw UnimplementedError());
      }
    } catch (error) {
      return Right(error);
    }
  }
}
