import 'package:dartz/dartz.dart';
import 'package:visitants/app/features/recover_password/data/repositories/recover_password_repository_impl.dart';

import '../../../../../core/failure.dart';

class RecoverPasswordUseCase {
  final RecoverPasswordRepositoryImpl repository;

  RecoverPasswordUseCase({required this.repository});
  Future<Either<Failure, dynamic>> recoverPasswordUseCase(
      {required dynamic email}) async {
    return repository.recoverPasswordRepository(email: email);
  }
}
