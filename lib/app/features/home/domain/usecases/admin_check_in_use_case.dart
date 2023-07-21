import 'package:dartz/dartz.dart';
import '../../../../../core/failure.dart';
import '../../data/repositories/home_repository_impl.dart';

class AdminCheckInUseCase {
  final HomeRepositoryImpl repository;

  AdminCheckInUseCase({required this.repository});

  Future<Either<Failure, bool>> adminCheckInUseCase() async {
    return repository.adminCheckInRepository();
  }
}
