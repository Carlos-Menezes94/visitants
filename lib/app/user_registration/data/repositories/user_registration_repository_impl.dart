import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visitants/app/user_registration/data/data_sources/user_registration_data_source_impl.dart';
import 'package:visitants/app/user_registration/domain/repositories/user_registration_repository_abstract.dart';
import '../../../../core/failure.dart';
import '../models/user_registered_data_model.dart';

class UserRegistrationRepositoryImpl
    implements UserRegistrationRepositoryAbstract {
  final UserRegistrationDataSourceImpl dataSourceImpl;

  UserRegistrationRepositoryImpl({required this.dataSourceImpl});
  @override
  Future<Either<Failure, dynamic>> newUserRegistrationRepository(
      {required UserRegisteredDataModel userRegisteredDataModel}) async {
    try {
      final response = await dataSourceImpl.newUserRegistration(
          userRegisteredDataModel: userRegisteredDataModel);
      if (response.success) {
        await FirebaseAuth.instance.signOut();
        return Right(response.data);
      } else {
        return Right(throw UnimplementedError());
      }
    } catch (error) {
      return Right(error);
    }
  }
}
