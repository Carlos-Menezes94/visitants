import 'package:dartz/dartz.dart';
import 'package:visitants/app/home/domain/repositories/home_repository_abstract.dart';
import '../../../../../core/failure.dart';

class AdminCheckInUseCase {
  final HomeRepositoryAbstract repository;

  AdminCheckInUseCase({required this.repository});

  Future<Either<Failure, bool>> adminCheckInUseCase({required String emailAdmin}) async {
    return repository.adminCheckInRepository(emailAdmin: emailAdmin);
  }
}
