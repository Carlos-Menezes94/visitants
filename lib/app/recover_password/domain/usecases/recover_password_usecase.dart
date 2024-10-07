import 'package:dartz/dartz.dart';
import '../../../../../core/failure.dart';
import '../../data/repositories/recover_password_repository_impl.dart';

class RecoverPasswordUseCase {
  final RecoverPasswordRepositoryImpl repository;

  RecoverPasswordUseCase({required this.repository});
  Future<Either<Failure, dynamic>> recoverPasswordUseCase(
      {required dynamic email}) async {
    return repository.recoverPasswordRepository(email: email);
  }
}
