import 'package:dartz/dartz.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../../../../core/failure.dart';
import '../../domain/repositories/recover_password_repository_abstract.dart';
import '../datasources/recover_password_data_source_impl.dart';
import '../failures/error_recover_password_failure.dart';
import '../failures/invalid_email_failure.dart.dart';
import '../failures/network_request_failed_failure.dart';
import '../failures/too_many_requests_failure.dart';
import '../failures/user_not_found_failure.dart';

class RecoverPasswordRepositoryImpl
    implements RecoverPasswordRepositoryAbstract {
  final RecoverPasswordDataSourceImpl recoverPasswordDataSourceImpl;

  RecoverPasswordRepositoryImpl({required this.recoverPasswordDataSourceImpl});
  @override
  Future<Either<Failure, dynamic>> recoverPasswordRepository(
      {required String email}) async {
    try {
      final response =
          await recoverPasswordDataSourceImpl.recoverPassword(email: email);
      if (response.success != true) {
        switch (response.data) {
          case "user-not-found":
            return Left(UserNotFoundFailure());
          case "invalid-email":
            return Left(InvalidEmailFailure());
          case "too-many-requests":
            return Left(TooManyRequestsFailure());
          case "network-request-failed":
            return Left(NetworkRequestFailedFailure());
          default:
            await Sentry.captureException(response.data);

            return Left(ErrorRecoverPasswordFailure());
        }
      } else {
        return const Right(true);
      }
    } catch (error) {
      return Left(ErrorRecoverPasswordFailure());
    }
  }
}
